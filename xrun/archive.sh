#使用方法

#工程路径
project_path="/Users/manwei/Desktop/gateio-app-ios-project"

#工程名
project_name="gateio_app"

#scheme名
scheme_name="gateio_app"

#ipa包名
ipa_name="gate.io.ipa"

#打包模式 Debug/Release
development_mode=Release

#build文件夹路径
build_path="/Users/manwei/Desktop/bash_sh/xrun/build"

#plist文件所在路径
exportOptionsPlistPath="/Users/manwei/Desktop/bash_sh/xrun/DevelopmentExportOptions.plist"

#导出.ipa文件所在路径
exportIpaPath="/Users/manwei/Desktop/bash_sh/xrun/archive"

#日志路径
logPath="/Users/manwei/Desktop/bash_sh/xrun/log"



#上传蒲公英配置
#uKey="38634d8041947f3c9e49abceb5d2052d"
#api_key="af5aae3c79f6f73c5e1219c02bc33b1e"

uKey="a6d03fadc5b3eb7cb7c62d3e41884402"
api_key="ed090240c6b7ea257cf6496215344588"

echo '///-----------'
echo '/// 正在清理工程'
echo '///-----------'
xcodebuild \
clean -workspace ${project_path}/${project_name}.xcworkspace -scheme $scheme_name \
-configuration ${development_mode}

#xcodebuild clean -workspace ${project_path}/${project_name}.xcworkspace -configuration ${development_mode} -alltargets -quiet  || exit

echo '///--------'
echo '/// 清理完成'
echo '///--------'
echo ''

echo '///-----------'
echo '/// 正在编译工程:'${development_mode}
echo '///-----------'
xcodebuild \
archive -workspace ${project_path}/${project_name}.xcworkspace \
-scheme ${scheme_name} \
-configuration ${development_mode} \
-archivePath ${build_path}/${project_name}.xcarchive  -quiet  || exit

echo '///--------'
echo '/// 编译完成'
echo '///--------'
echo ''

echo '///----------'
echo '/// 开始ipa打包'
echo '///----------'
xcodebuild -exportArchive -archivePath ${build_path}/${project_name}.xcarchive \
-configuration ${development_mode} \
-exportPath ${exportIpaPath} \
-exportOptionsPlist ${exportOptionsPlistPath} \
-quiet || exit

if [ -e $exportIpaPath/$ipa_name ]; then
echo '///----------'
echo '/// ipa包已导出'
echo '///----------'
#open $exportIpaPath

sleep 5.0
echo '///-------------'
echo '/// 开始发布ipa包 '
echo '///-------------'

#curl -F "file=@${exportIpaPath}/${project_name}.ipa" -F uKey="${uKey}" -F _api_key="${api_key}" https://qiniu-storage.pgyer.com/apiv1/app/upload


else
echo '///-------------'
echo '/// ipa包导出失败 '
echo '///-------------'
fi
echo '///------------'
echo '/// 打包ipa完成  '
echo '///-----------='
echo ''




exit 0
