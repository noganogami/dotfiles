import {
  BaseConfig,
  ConfigReturn,
  ContextBuilder,
  Dpp,
  Plugin,
} from "https://deno.land/x/dpp_vim@v0.2.0/types.ts";
import { Denops, fn } from "https://deno.land/x/dpp_vim@v0.2.0/deps.ts";

export class Config extends BaseConfig {
  override async config(args: {
    denops: Denops;
    contextBuilder: ContextBuilder;
    basePath: string;
    dpp: Dpp;
  }): Promise<ConfigReturn> {
    args.contextBuilder.setGlobal({
      protocols: ["git"],
    });

    const [context, options] = await args.contextBuilder.get(args.denops);

    const configDir = await args.denops.call("stdpath", "config") as string;
    const tomlDir = `${configDir}/toml`;
    const isNvim = await fn.has(args.denops, "nvim");

    const tomls = [
      { path: `${tomlDir}/dpp.toml`, lazy: false },
      { path: `${tomlDir}/dein.toml`, lazy: false },
      { path: `${tomlDir}/ddu.toml`, lazy: false },
      { path: `${tomlDir}/dein_lazy.toml`, lazy: true },
    ];

    if (isNvim) {
      tomls.push({ path: `${tomlDir}/nvim.toml`, lazy: false });
      tomls.push({ path: `${tomlDir}/nvim_lazy.toml`, lazy: true });
    } else {
      tomls.push({ path: `${tomlDir}/vim.toml`, lazy: false });
      tomls.push({ path: `${tomlDir}/vim_lazy.toml`, lazy: true });
    }

    const recordPlugins: Record<string, Plugin> = {};
    const ftplugins: Record<string, string> = {};
    const hooksFiles: string[] = [];

    for (const toml of tomls) {
      const tomlRes = await args.dpp.extAction(
        args.denops,
        context,
        options,
        "toml",
        "load",
        {
          path: toml.path,
          options: {
            lazy: toml.lazy,
          },
        },
      ) as {
        plugins?: Plugin[];
        ftplugins: Record<string, string>;
        hooks_file: string;
      } | undefined;

      if (!tomlRes || !Array.isArray(tomlRes.plugins)) {
        throw new Error(
          `Failed to load TOML plugins: ${toml.path}. Check the preceding dpp-ext-toml error.`,
        );
      }

      for (const plugin of tomlRes.plugins) {
        recordPlugins[plugin.name] = plugin;
      }

      if (tomlRes.ftplugins) {
        for (const [ft, code] of Object.entries(tomlRes.ftplugins)) {
          ftplugins[ft] = (ftplugins[ft] || "") + code;
        }
      }

      if (tomlRes.hooks_file) {
        hooksFiles.push(tomlRes.hooks_file);
      }
    }

    const lazyRes = await args.dpp.extAction(
      args.denops,
      context,
      options,
      "lazy",
      "makeState",
      {
        plugins: Object.values(recordPlugins),
      },
    ) as ConfigReturn;

    return {
      ...lazyRes,
      ftplugins,
      hooksFiles,
    };
  }
}
