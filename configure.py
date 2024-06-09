#!/usr/bin/python
import re
import sys
import copy
import ipaddress
from configparser import ConfigParser, SectionProxy

CONFIG_PATH = sys.argv[1]
config = ConfigParser()
config.read(CONFIG_PATH)

username_regex = re.compile(r"^[a-z_]([a-z0-9_-]{0,31}|[a-z0-9_-]{0,30}\$)$")
servername_regex = re.compile(r"^[A-Z][A-Za-z0-9]{0,100}$")


def main() -> None:
    while True:
        print("\nChoose option:")
        print("1. Add server")
        print("2. Delete server")
        print("3. Change server configuration")
        print("4. Import config from existing file")
        print("5. Save and exit")
        print("228. Do not save and exit")
        option = input()

        match option:
            case "1":
                add_server()
            case "2":
                delete_server()
            case "3":
                reconfigure()
            case "4":
                import_from_file()
            case "5":
                res = input("Save and exit. Are you sure?[y/N]: ")
                if res == "y":
                    return
            case "228":
                res = input(
                    "Changes will not be applied! Are you sure?[y/N]: ")
                if res == "y":
                    exit()
            case _:
                print_red("Invalid option!")


def add_server() -> None:
    ip = input("Enter server IP: ")
    if not ip_is_valid(ip):
        return
    name = input("Enter server name: ")
    if not servername_is_valid(name):
        return
    users = input("Enter server users separated by comma: ").replace(" ", "")
    if not userlist_is_valid(users.split(",")):
        return
    config[name] = {"IP": ip, "USERS": users}
    print_success()


def delete_server() -> None:
    name = input("Enter server name: ")
    if name not in config.sections():
        print_red("This server does not exist!")
    config.remove_section(name)
    print_success()


def reconfigure() -> None:
    name = input("Enter server name: ")

    temp_values = copy.deepcopy(config[name])

    while True:
        print("\nChoose option:")
        print("1. Change IP")
        print("2. Change server name")
        print("3. Add user")
        print("4. Delete user")
        print("5. Init users")
        print("6. Save and exit to main menu")
        print("228. Do not save and exit to main menu")
        option = input()

        match option:
            case "1":
                ip_string = input("Enter new IP address: ")
                if ip_is_valid(ip_string):
                    temp_values["IP"] = ip_string
                    print_success()
            case "2":
                new_servername = input("Enter new server name: ").strip()
                if servername_is_valid(new_servername):
                    temp_values.name = new_servername
                    print_success()
            case "3":
                print("Current users:")
                print(temp_values["Users"])
                new_user = input("Enter new user name: ").strip()
                if not username_is_valid(new_user):
                    continue
                if new_user not in temp_values["Users"].split(","):
                    temp_values["Users"] += "," + new_user
                    print_success()
                else:
                    print_red("User already exists!")
            case "4":
                print("Current users:")
                print(temp_values["Users"])
                user_to_delete = input("Enter user name to delete:")
                userlist = temp_values["Users"].split(",")
                if user_to_delete in userlist:
                    userlist.remove(user_to_delete)
                    temp_values["Users"] = ",".join(userlist)
                    print_success()
                else:
                    print_red("User does not exist!")
            case "5":
                print("Current users:")
                print(temp_values["Users"])
                new_userlist = input("Enter list of users separated by comma: ").replace(
                    " ", "").split(",")
                if userlist_is_valid(new_userlist):
                    temp_values["Users"] = ",".join(set(new_userlist))
                    print_success()
            case "6":
                decision = input("Save and exit. Are you sure?[y/N]: ")
                if decision == "y":
                    config[name] = temp_values
                    return
            case "228":
                decision = input(
                    "Changes will not be applied! Are you sure?[y/N]: ")
                if decision == "y":
                    return
            case _:
                print_red("Invalid option!")


def import_from_file() -> None:
    filepath = input("Enter path to file: ")
    config.read(filepath)
    print_success()


def ip_is_valid(ip_string: str) -> bool:
    try:
        ipaddress.ip_address(ip_string)
        return True
    except:
        print_red(f"{ip_string} is not a valid IP address!")
        return False


def username_is_valid(username: str) -> bool:
    res = bool(username_regex.match(username))
    if not res:
        print_red(
            f"\"{username}\" is not a valid username!\nShould be up to Linux standards!")
    return res


def servername_is_valid(servername: str) -> bool:
    res = bool(servername_regex.match(servername))
    if not res:
        print_red(f"{servername} is not a valid server name!\nShould start with capital letter and consist only letters and numbers!\nMaximum length is 101!")
    return res


def userlist_is_valid(userlist: list[str]) -> bool:
    res = True
    for username in userlist:
        if not username_is_valid(username):
            res = False
    return res


def print_red(text: str) -> None:
    print(f"\033[91m{text}\033[0m")


def print_success() -> None:
    print("\033[92mSuccess\033[0m")


if __name__ == '__main__':
    main()
    with open(CONFIG_PATH, "w") as file:
        config.write(file)
