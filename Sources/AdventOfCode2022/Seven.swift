import Foundation

struct Seven {

    enum Command {
        case moveIn(to: String)
        case moveOut
        case moveToRoot
        case list(folders: [Folder], files: [File])
    }

    struct File {
        let name: String
        let size: Int
    }

    class Folder {
        let name: String
        var files: [File]
        var subfolders: [Folder]
        var parent: Folder?

        init(name: String, files: [File], subfolders: [Folder]) {
            self.name = name
            self.files = files
            self.subfolders = subfolders
        }

        var root: Folder { name == "root" ? self : parent!.root }

        var size: Int {
            let fileSizes = files.map { $0.size }.reduce(0,+)
            let folderSizes = subfolders.map { $0.size }.reduce(0,+)
            return fileSizes + folderSizes
        }

        func foldersAtLeast(size: Int) -> [Folder] {
            let subfolders = subfolders.map { $0.foldersAtLeast(size: size) }.flatMap { $0 }
            return self.size >= size ? [self] + subfolders : subfolders
        }

        func foldersAtMost(size: Int) -> [Folder] {
            let subfolders = subfolders.map { $0.foldersAtMost(size: size) }.flatMap { $0 }
            return self.size <= size ? [self] + subfolders : subfolders
        }
    }

    private func parsed(input: String) -> [Command] {
        let split = input
            .split(separator: "\n")
            .map { String($0) }

        return parseCommand(in: split)
    }

    func findFoldersSmaller(than size: Int, in input: String) -> Int {
        let commands = parsed(input: input)
        let root = run(commands: commands)
        let filered = root.foldersAtMost(size: size)
        let res = filered.map { $0.size }.reduce(0, +)
        return res
    }

    func deleteSmallest(in input: String) -> Int {
        let totalSpace = 70_000_000
        let requiredSpace = 30_000_000
        let commands = parsed(input: input)
        let root = run(commands: commands)
        let currentSpace = totalSpace - root.size
        let filtered = root.foldersAtLeast(size: requiredSpace - currentSpace)
        let smallest = filtered.min { $0.size < $1.size }

        return smallest!.size
    }

    private func run(commands: [Command]) -> Folder {
        let root = Folder(name: "root", files: [], subfolders: [])
        var currentFolder = root
        commands.forEach {
            currentFolder = apply(command: $0, currentFolder: currentFolder)
        }

        return root
    }

    private func apply(command: Command, currentFolder: Folder) -> Folder {
        switch command {
        case let .moveIn(folder):
            if let next = currentFolder.subfolders.first(where: { $0.name == folder }) {
                return next
            }
            let newFolder = Folder(name: folder, files: [], subfolders: [])
            currentFolder.subfolders.append(newFolder)
            newFolder.parent = currentFolder
            return newFolder

        case .moveOut:
            return currentFolder.parent!
        case .moveToRoot:
            return currentFolder.root
        case let .list(folders, files):
            let filteredFolders = folders
                .filter { subfolder -> Bool in
                    !currentFolder.subfolders.contains { subfolder.name == $0.name }
                }

            filteredFolders.forEach {
                $0.parent = currentFolder
            }

            currentFolder.subfolders.append(contentsOf: filteredFolders)
            currentFolder.files.append(contentsOf: files)
            return currentFolder
        }
    }

    private func parseCommand(in input: [String]) -> [Command] {
        guard !input.isEmpty else { return [] }

        let current = input.first!
        var nextInput = input.suffix(from: 1)
        assert(current.starts(with: "$"))
        let next = current.dropFirst(2)
        let command: Command

        switch current.dropFirst(2) {
        case "ls":
            command = parseFiles(in: nextInput.prefix { !$0.starts(with: "$") })
            nextInput = nextInput.drop { !$0.starts(with: "$") }
        case "cd ..":
            command = .moveOut
        case "cd /":
            command = .moveToRoot
        default:
            let to = String(next.dropFirst(2))
            command = .moveIn(to: to)
        }

        return [command] + parseCommand(in: Array(nextInput))
    }

    private func parseFiles(in input: [String]) -> Command {
        let folders = input
            .filter { $0.starts(with: "dir") }
            .map { String($0.dropFirst(3)) }
            .map { Folder(name: $0, files: [], subfolders: []) }
        let files = input
            .filter { !$0.starts(with: "dir") }
            .map { $0.split(separator: " ").map { String($0) } }
            .map {return File(name: $0.last!, size: Int($0.first!)!) }

        return .list(folders: folders, files: files)
    }
}
