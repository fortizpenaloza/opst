StartupPreferencesLoader default executeAtomicItems:
  {
    (StartupAction
      name: 'Define startup context'
      code: [ | properties|

        properties := FileStream
          readOnlyFileNamed: 'user-properties'
          do: [:file | STONJSON fromString: file contentsOfEntireFile ].

        Smalltalk globals at: #StartupContext ifAbsentPut: properties ]
      runOnce: true).

    (StartupAction
      name: 'Set author name'
      code: [
        Author fullName: (StartupContext at: #author) ]
      runOnce: true).

    (StartupAction
      name: 'Setup fonts'
      code: [
        StandardFonts
          defaultFont: (LogicalFont familyName: 'Source Sans Pro' pointSize: 10) forceNotBold.
          GraphicFontSettings resetAllFontToDefault.
          StandardFonts windowTitleFont: (LogicalFont familyName: 'Source Sans Pro' pointSize: 12) forceBold.
          StandardFonts codeFont: (LogicalFont familyName: 'Source Code Pro' pointSize: 11) ]
      runOnce: true).

    (StartupAction
      name: 'Set up UI theme'
      code: [ Pharo3Theme beCurrent ]
      runOnce: true).

    (StartupAction
      name: 'Setup syntax highlighting style'
      code: [ SHPreferences setStyleTableNamed: 'Solarized' ]
      runOnce: true).

    (StartupAction
      name: 'Debugger options'
      code: [ Smalltalk tools debugger alwaysOpenFullDebugger: true ]
      runOnce: true).

    (StartupAction
      name: 'Code formatting options'
      code: [
        BIConfigurableFormatter
          newLinesAfterTemporaries: 2;
          newLinesAfterMethodPattern: 2;
          retainBlankLinesBetweenStatements: true;
          newLineBeforeFirstCascade: false;
          newLineBeforeFirstCascade: true;
          yourself ]
      runOnce: true).

    (StartupAction
      name: 'Upgrade FPS to 60'
      code: [ WorldState MinCycleLapse: 16 ]
      runOnce: true).

    (StartupAction
      name: 'Autocompletion options'
      code: [ NECPreferences caseSensitive: false ]
      runOnce: true).

    (StartupAction
      name: 'Enable Iceberg Metacello integration'
      code: [ Iceberg enableMetacelloIntegration ]
      runOnce: true).

    (StartupAction
        name: 'Set iceberg shared repository'
        code: [ IceRepository shareRepositoriesBetweenImages: true.
                IceRepository sharedRepositoriesLocationString: ((StartupContext at: #iceberg) at: #shared_directory) ]
        runOnce: true).

    (StartupAction
        name: 'Set Iceberg default code subdirectory'
        code: [ IceRepository defaultCodeSubdirectory: ((StartupContext at: #iceberg) at: #code_subdirectory) ]
        runOnce: true).

    (StartupAction
        name: 'Clean startup context'
        code: [ Smalltalk globals removeKey: #StartupContext ]
        runOnce: true).

    (StartupAction
      name: 'Show any startup action errors'
      code: [
        StartupPreferencesLoader default errors
          ifNotEmpty: [ :errors | errors explore ] ]
      runOnce: true).
  }
