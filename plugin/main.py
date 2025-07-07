import cc.plugin_manager as manager
import logging
import sys

dataSourceName = "TestFile"
dataSourcePath = "default"


def main():

    pm = manager.PluginManager()

    ########## logging ############
    # the default log level is INFO
    # the log level can be set using
    # the CC_LOGGING_LEVEL environment
    # variable

    ###############################
    ########## payload ############
    pl = pm.get_payload()

    for attr in pl.attributes:
        print(attr)

    for store in pl.stores:
        print(store.name)

    for input in pl.inputs:
        print(input)

    for output in pl.outputs:
        print(output)

    for action in pl.actions:
        print(action)

    ######################################
    ## Plugin Manager utility functions ##
    ######################################

    # get a data source by name
    data_source = pm.get_input_data_source(dataSourceName)
    # you can also use pm.get_output_data_source and
    # pm.get_data_source to retrieve data sources by name

    # get a store by name
    data_store = pm.get_store(data_source.store_name)

    # you shouldn't need to do this, but for direct low level access to the
    # store you can get the raw session
    session = data_store._session

    # get a remote resource as a reader
    # for file or object resources the datapath is set to None
    reader = pm.get_reader(dataSourceName, dataSourcePath, None)
    content = reader.read()
    print(content)

    # get a remote resource as a byte array
    content = pm.get(dataSourceName, dataSourcePath, None)
    print(content)

    # push data to a remote resource
    reader = pm.get_reader(dataSourceName, dataSourcePath, None)
    pm.put(reader, "TestFileOut", "default", None)

    # copy a file to the local container
    pm.copy_file_to_local(manager.DataSourceOpInput(name="TestFile", pathkey="default", datakey=None), "/data/testfile.txt")  # data source name

    # copy a local file to a remote
    pm.copy_file_to_remote(manager.DataSourceOpInput(name="TestFileOut2", pathkey="default", datakey=None), "/data/testfile.txt")  # data source name

    # copy one data source to another
    pm.copy(
        manager.DataSourceOpInput(name="TestFile", pathkey="default", datakey=None),  # data source name
        manager.DataSourceOpInput(name="TestFileOut2", pathkey="default", datakey=None),  # data source name
    )

    ######################################
    ## Actions                          ##
    ######################################

    # actions have most of the functionality of the plugin manager but are specific to an individual action
    # you can access them directly:
    action = pl.actions[0]
    # but typically you loop over the list of actions and run them in order:

    for action in pl.actions:
        match action.type:
            case "action1":
                do_stuff_with_an_action(action)
            case "action2":
                # do action 2
                pass
            case _:
                # handle unknown action..probably just throw an error
                pass


def do_stuff_with_an_action(action):
    print(action.type)
    print(action.description)

    # the attribute dictionary is accessible via the attribute property
    attrs = action.attributes

    # get the list of inputs
    inputs = action.inputs()

    # get the list of outputs
    outputs = action.outputs()

    # get a data source by name
    data_source = action.get_input_data_source(dataSourceName)
    # you can also use pm.get_output_data_source and
    # pm.get_data_source to retrieve data sources by name

    # get a store by name
    data_store = action.get_store(data_source.store_name)

    # get a remote resource as a reader
    # for file or object resources the datapath is set to None
    reader = action.get_reader(dataSourceName, dataSourcePath, None)
    content = reader.read()
    print(content)

    # get a remote resource as a byte array
    content = action.get(dataSourceName, dataSourcePath, None)
    print(content)

    # push data to a remote resource
    reader = action.get_reader(dataSourceName, dataSourcePath, None)
    action.put(reader, "TestFileOut", "default", None)

    # copy a file to the local container
    action.copy_file_to_local(manager.DataSourceOpInput(name="TestFile", pathkey="default", datakey=None), "/data/testfile.txt")  # data source name

    # copy a local file to a remote
    action.copy_file_to_remote(manager.DataSourceOpInput(name="TestFileOut2", pathkey="default", datakey=None), "/data/testfile.txt")  # data source name

    # copy one data source to another
    action.copy(
        manager.DataSourceOpInput(name="TestFile", pathkey="default", datakey=None),  # data source name
        manager.DataSourceOpInput(name="TestFileOut2", pathkey="default", datakey=None),  # data source name
    )


if __name__ == "__main__":
    main()
