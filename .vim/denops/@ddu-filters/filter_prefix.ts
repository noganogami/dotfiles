import {
  BaseFilter,
  DduItem,
} from 'https://deno.land/x/ddu_vim@v3.5.0/types.ts';
import { Denops } from 'https://deno.land/x/ddu_vim@v3.5.0/deps.ts';

type Params = Record<string, never>;

export class Filter extends BaseFilter<Params> {
  override filter(args: {
    denops: Denops;
    items: DduItem[];
  }): Promise<DduItem[]> {
    return Promise.resolve(
      args.items.filter((item) => {
        const firstChar = item.word[0]; // 文字列の最初の文字を取得
        return firstChar >= 'a' && firstChar <= 'z'; // アルファベットの範囲内かどうかをチェック
      }),
    );
  }

  override params(): Params {
    return {};
  }
}
