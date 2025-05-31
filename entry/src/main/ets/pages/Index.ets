import { hilog } from '@kit.PerformanceAnalysisKit';
import testNapi from 'libentry.so';
import sdltest from 'libSDL3.so';

const DOMAIN = 0x0000;

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize($r('app.float.page_text_font_size'))
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            this.message = 'Welcome';
            hilog.info(DOMAIN, 'testTag', 'Test NAPI 2 + 3 = %{public}d', testNapi.add(2, 3));
            hilog.info(DOMAIN, 'testTag', 'Test SDL 2 - 1 = %{public}d', sdltest.minus(2, 1));
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}
