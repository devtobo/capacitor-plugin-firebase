declare global {
  interface PluginRegistry {
    Firebase?: FirebasePlugin;
  }
}

export type FirebaseLogEventParameters = { [key: string]: number | string }

export interface FirebasePlugin {
  logEvent(options: { name: string, parameters?: FirebaseLogEventParameters }): void
}
