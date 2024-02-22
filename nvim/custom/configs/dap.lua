local dap = require("dap")

dap.adapters['pwa-node'] = {
  type = 'server',
  host = 'localhost',
  port = '${port}',
  executable = {
    command = 'js-debug-adapter',
    args = { '${port}' },
  }
}

dap.adapters.java = {
  type = "executable",
  command = "java",
  args = {
    "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005",
  },
  env = {
    JAVA_HOME = "/usr/lib/jvm/java-17-openjdk-17.0.8.0.7-1.fc38.x86_64/bin/java",
  },
  name = "java-debug",
}

dap.configurations.java = {
  {
    type = "java",
    request = "launch",
    name = "Java Debug",
    stopOnEntry = false,
    mainClass = "com.example.MainClass", -- Replace with your main class
    projectRoot = "${workspaceFolder}",
    classPath = "${workspaceFolder}/bin", -- Path to your compiled Java classes
    sourcePaths = { "${workspaceFolder}/src" }, -- Source code location
    runOptions = "",
    args = {},
  },
}


for _, language in ipairs { 'typescript', 'javascript' } do
  dap.configurations[language] = {
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch file',
      program = '${file}',
      cwd = '${workspaceFolder}',
    },
  }
end