import { hilog } from '@kit.PerformanceAnalysisKit';
import testNapi from 'libentry.so';
import sdltest from 'libSDL3.so';

const DOMAIN = 0x0000;

export class ArkNapiCallback {
  test(): number {
    hilog.info(DOMAIN, 'testTag', 'Call from native !!!'); // 竟然一次就成功了（（（
    focusControl.requestFocus("inputHandler")
    return 1;
  }
}

let callbackRef: ArkNapiCallback = new ArkNapiCallback()

function sdlCallbackInitImpl() {
  sdltest.sdlCallbackInit(callbackRef)
}

@Entry
@Component
struct Index {
  aboutToAppear(): void {
    sdlCallbackInitImpl()
    hilog.info(DOMAIN, 'testTag', 'Test SDL 2 - 1 = %{public}d', sdltest.minus(2, 1))
    hilog.info(DOMAIN, 'testTag', 'Test NAPI 2 + 3 = %{public}d', testNapi.add(2, 3))
  }

  build() {
    Stack() {
      TextInput().key('inputHandler').onChange((value: string) => {
        hilog.info(DOMAIN, 'testTag', value)
      }).onSubmit(() => {
        hilog.info(DOMAIN, 'testTag', "submit")
      })
      XComponent({ id: 'test', type: 'surface', libraryname: 'SDL3' }).key("mainView")
    }
  }
}
