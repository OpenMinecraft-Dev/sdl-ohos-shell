#include "SDL3/SDL_video.h"
#include "SDL3/SDL_vulkan.h"
#include "napi/native_api.h"
#include "SDL3/SDL_log.h"
#include "SDL3/SDL_hints.h"
#include <stdlib.h>

static napi_value Add(napi_env env, napi_callback_info info)
{
    size_t argc = 2;
    napi_value args[2] = {nullptr};

    napi_get_cb_info(env, info, &argc, args , nullptr, nullptr);

    napi_valuetype valuetype0;
    napi_typeof(env, args[0], &valuetype0);

    napi_valuetype valuetype1;
    napi_typeof(env, args[1], &valuetype1);

    double value0;
    napi_get_value_double(env, args[0], &value0);

    double value1;
    napi_get_value_double(env, args[1], &value1);

    napi_value sum;
    napi_create_double(env, value0 + value1, &sum);

    SDL_Log("Add invoke!");

    return sum;

}

EXTERN_C_START
static napi_value Init(napi_env env, napi_value exports)
{
    napi_property_descriptor desc[] = {
        { "add", nullptr, Add, nullptr, nullptr, nullptr, napi_default, nullptr }
    };
    napi_define_properties(env, exports, sizeof(desc) / sizeof(desc[0]), desc);
    return exports;
}

int main()
{
    SDL_Log("Main func invoke !!!");
    SDL_SetHint(SDL_HINT_EGL_LIBRARY, "libEGL.so");
    SDL_SetHint(SDL_HINT_OPENGL_LIBRARY, "libGLESv3.so");
    SDL_SetHint(SDL_HINT_OPENGL_ES_DRIVER, "libGLESv3.so");
    SDL_GL_LoadLibrary(nullptr);
    SDL_Window* win = SDL_CreateWindow("test", 1024, 1024, SDL_WINDOW_OPENGL);
    SDL_Vulkan_LoadLibrary(nullptr);
    unsigned int c = 0;
    const char* const* data = SDL_Vulkan_GetInstanceExtensions(&c);
    SDL_Log("Main func invoke !!! %s %p %s %s", SDL_GetError(), win, data[0], data[1]);
    
    return 0;
}
EXTERN_C_END

static napi_module demoModule = {
    .nm_version = 1,
    .nm_flags = 0,
    .nm_filename = nullptr,
    .nm_register_func = Init,
    .nm_modname = "entry",
    .nm_priv = ((void*)0),
    .reserved = { 0 },
};

extern "C" __attribute__((constructor)) void RegisterEntryModule(void)
{
    napi_module_register(&demoModule);
}
