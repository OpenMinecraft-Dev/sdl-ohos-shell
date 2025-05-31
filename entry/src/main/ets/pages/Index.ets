import { hilog } from '@kit.PerformanceAnalysisKit';
import testNapi from 'libentry.so';
import sdltest from 'libSDL3.so';

const DOMAIN = 0x0000;

@Entry
@Component
struct Index {
  aboutToAppear(): void {
    hilog.info(DOMAIN, 'testTag', 'Test SDL 2 - 1 = %{public}d', sdltest.minus(2, 1));
    hilog.info(DOMAIN, 'testTag', 'Test NAPI 2 + 3 = %{public}d', testNapi.add(2, 3));
  }

  build() {
    Stack() {
      XComponent({ id: 'test', type: 'surface', libraryname: 'SDL3' })
    }
  }
}
