import { hilog } from '@kit.PerformanceAnalysisKit';
import testNapi from 'libentry.so';
import sdltest from 'libSDL3.so';
import { intl } from '@kit.LocalizationKit';

const DOMAIN = 0x0000;

export class ArkNapiCallback {
  test(): number {
    hilog.info(DOMAIN, 'testTag', 'Call from native !!!');
    focusControl.requestFocus("inputHandler")
    let locale = new intl.Locale();
    hilog.info(DOMAIN, 'testTag', locale.toString());
    return 1;
  }
}

let callbackRef: ArkNapiCallback = new ArkNapiCallback()

function sdlCallbackInitImpl() {
  sdltest.sdlCallbackInit(callbackRef)
}

async function sdlMain(): Promise<void> {
  const result =
    await new Promise<number>((resolve, reject) => {
      setTimeout(() => {
        sdltest.sdlLaunchMain("libentry.so", "main")
        resolve(0);
      }, 1000)
    })
}

@Entry
@Component
struct Index {
  aboutToAppear(): void {
    sdlCallbackInitImpl()
    sdlMain()
  }

  build() {
    Column() {
      XComponent({ id: 'mainView', type: 'surface', libraryname: 'SDL3' })
        .id('mainView')
        .backgroundColor('#999999')
      TextInput().id('inputHandler').onChange((value: string) => {
        hilog.info(DOMAIN, 'testTag', value)
      }).onSubmit(() => {
        hilog.info(DOMAIN, 'testTag', "submit")
      })

    }
    .alignItems(HorizontalAlign.End)
    .justifyContent(FlexAlign.End)
  }
}
