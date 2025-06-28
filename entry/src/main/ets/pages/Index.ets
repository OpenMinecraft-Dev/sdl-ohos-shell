import { hilog } from '@kit.PerformanceAnalysisKit';
import sdltest from 'libSDL3.so';
import { intl } from '@kit.LocalizationKit';

const DOMAIN = 0x0000;

export class ArkNapiCallback {
  onMainLaunch() {
    sdltest.sdlLaunchMain("libentry.so", "main")
  }
  test(): number {
    hilog.info(DOMAIN, 'testTag', 'Call from native !!!');
    focusControl.requestFocus("inputHandler")
    let locale = new intl.Locale();
    hilog.info(DOMAIN, 'testTag', locale.toString());
    return 1;
  }
}

let callbackRef: ArkNapiCallback = new ArkNapiCallback()

@Entry
@Component
struct Index {
  aboutToAppear(): void {
    sdltest.sdlCallbackInit(callbackRef)
  }

  build() {
    Column() {
      XComponent({ id: 'mainView', type: 'surface', libraryname: 'SDL3' })
        .id('mainView')
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
