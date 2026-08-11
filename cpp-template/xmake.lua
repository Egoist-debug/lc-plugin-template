-- xmake 构建配置
-- 用法：
--   xmake            # 编译全部目标
--   xmake build <目标名>   # 编译单个目标
--   xmake run <目标名>     # 编译并运行单个目标
set_project("cpp_template")
set_version("1.0.0")

add_rules("mode.debug", "mode.release")
set_languages("c++20")

-- 公共代码（链表、二叉树等工具类），编译为静态库
target("common")
    set_kind("static")
    add_files("leetcode/editor/common/*.cpp")

-- 为 cn/en 目录下每个题解文件生成独立可执行目标
-- 目标名规则：editor_<目录>_<文件名>（如 editor_cn_merge-two-sorted-lists）
for _, dir in ipairs({ "cn", "en" }) do
    for _, file in ipairs(os.files("leetcode/editor/" .. dir .. "/*.cpp")) do
        local name = "editor_" .. dir .. "_" .. path.basename(file)
        target(name)
            set_kind("binary")
            add_files(file)
            add_deps("common")
    end
end

