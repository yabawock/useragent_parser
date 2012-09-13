# encoding: utf-8

require 'spec_helper'

describe UseragentParser::UserAgent do
  describe "for browser details" do
    it "should report the browser family" do
      UseragentParser::UserAgent.new({ 'user_agent' => { 'family' => 'Chrome', 'major' => '14', 'minor' => '0', 'patch' => '835' } }).browser_family.should == 'Chrome'
    end

    it "should report the browser major version" do
      UseragentParser::UserAgent.new({ 'user_agent' => { 'family' => 'Chrome', 'major' => '14', 'minor' => '0', 'patch' => '835' } }).browser_major_version.should == '14'
    end

    it "should report the browser minor version" do
      UseragentParser::UserAgent.new({ 'user_agent' => { 'family' => 'Chrome', 'major' => '14', 'minor' => '0', 'patch' => '835' } }).browser_minor_version.should == '0'
    end

    it "should report the browser patch version" do
      UseragentParser::UserAgent.new({ 'user_agent' => { 'family' => 'Chrome', 'major' => '14', 'minor' => '0', 'patch' => '835' } }).browser_patch_version.should == '835'
    end

    it "should report the browser version" do
      UseragentParser::UserAgent.new({ 'user_agent' => { 'family' => 'Chrome', 'major' => '14', 'minor' => '0', 'patch' => '835' } }).browser_version.should == '14.0.835'
    end

    it "should report the browser version without patch level" do
      UseragentParser::UserAgent.new({ 'user_agent' => { 'family' => 'Firefox', 'major' => '5', 'minor' => '0' } }).browser_version.should == '5.0'
    end

    it "should report the browser version without minor version" do
      UseragentParser::UserAgent.new({ 'user_agent' => { 'family' => 'Firefox', 'major' => '5' } }).browser_version.should == '5'
    end

    it "should report the browser family without version" do
      UseragentParser::UserAgent.new({ 'user_agent' => { 'family' => 'Opera' } }).browser_version.should == ''
    end
  end

  describe "for device details" do
    it "should report mobile classification" do
      UseragentParser::UserAgent.new({ 'device' => { 'family' => nil, 'is_mobile' => false, 'is_spider' => false } }).is_mobile?.should be_false
      UseragentParser::UserAgent.new({ 'device' => { 'family' => nil, 'is_mobile' => true, 'is_spider' => false } }).is_mobile?.should be_true
    end

    it "should report spider classification" do
      UseragentParser::UserAgent.new({ 'device' => { 'family' => nil, 'is_mobile' => false, 'is_spider' => false } }).is_spider?.should be_false
      UseragentParser::UserAgent.new({ 'device' => { 'family' => nil, 'is_mobile' => false, 'is_spider' => true } }).is_spider?.should be_true
    end

    it "should report device platform" do
      UseragentParser::UserAgent.new({ 'device' => { 'family' => 'iPad', 'is_mobile' => true, 'is_spider' => false } }).device.should == "iPad"
      UseragentParser::UserAgent.new({ 'device' => { 'family' => 'iPod', 'is_mobile' => true, 'is_spider' => false } }).device.should == "iPod"
      UseragentParser::UserAgent.new({ 'device' => { 'family' => 'iPhone', 'is_mobile' => true, 'is_spider' => false } }).device.should == "iPhone"
      UseragentParser::UserAgent.new({ 'device' => { 'family' => 'GT-P7510', 'is_mobile' => true, 'is_spider' => false } }).device.should == "GT-P7510"
      UseragentParser::UserAgent.new({ 'device' => { 'family' => 'Blackberry Playbook', 'is_mobile' => true, 'is_spider' => false } }).device.should == "Blackberry Playbook"
      UseragentParser::UserAgent.new({ 'device' => { 'family' => 'Spider', 'is_mobile' => false, 'is_spider' => true } }).device.should == "Spider"
    end
  end

  describe "for operating system details" do
    it "should report the os family" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '3', 'minor' => '1' } }).os_family.should == 'Windows NT'
    end

    it "should report the major os version" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '3', 'minor' => '1' } }).os_major_version.should == '3'
    end

    it "should report the minor os version" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '3', 'minor' => '1' } }).os_minor_version.should == '1'
    end

    it "should report the os patchlevel" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '3', 'minor' => '1' } }).os_patch_version.should be_nil
    end

    it "should report the os version" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '3', 'minor' => '1' } }).os_version.should == '3.1'
    end

    it "should know the code name for Windows NT 3.1" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '3', 'minor' => '1' } }).os.should == 'Microsoft Windows NT 3.1'
    end

    it "should know the code name for Windows NT 3.5" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '3', 'minor' => '5' } }).os.should == 'Microsoft Windows NT 3.5'
    end

    it "should know the code name for Windows NT 4.0" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '4', 'minor' => '0' } }).os.should == 'Microsoft Windows NT 4.0'
    end

    it "should know the code name for Windows 2000" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '5', 'minor' => '0' } }).os.should == 'Microsoft Windows 2000'
    end

    it "should know the code name for Windows XP" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '5', 'minor' => '1' } }).os.should == 'Microsoft Windows XP'
    end

    it "should know the code name for Windows XP 64bit / Server 2003" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '5', 'minor' => '2' } }).os.should == 'Microsoft Windows XP 64bit / Server 2003'
    end

    it "should know the code name for Windows Vista / Server 2008" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '6', 'minor' => '0' } }).os.should == 'Microsoft Windows Vista / Server 2008'
    end

    it "should know the code name for Windows 7 / Server 2008 R2" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '6', 'minor' => '1' } }).os.should == 'Microsoft Windows 7 / Server 2008 R2'
    end

    it "should know the code name for Windows 8" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '6', 'minor' => '2' } }).os.should == 'Microsoft Windows 8'
    end

    it "should know the code name for Windows 3.1" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows', 'major' => '3', 'minor' => '1' } }).os.should == 'Microsoft Windows 3.1'
    end

    it "should know the code name for Windows 95" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows', 'major' => '95' } }).os.should == 'Microsoft Windows 95'
    end

    it "should know the code name for Windows 98" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows', 'major' => '98' } }).os.should == 'Microsoft Windows 98'
    end

    it "should know the code name for Windows ME" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows', 'major' => 'ME' } }).os.should == 'Microsoft Windows ME'
    end

    it "should know the code name for Windows 9x" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows', 'major' => '9x' } }).os.should == 'Microsoft Windows 9x'
    end

    it "should know the code name for Mac OS X 10.0" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Mac OS X', 'major' => '10', 'minor' => '0' } }).os.should == 'Apple Mac OS X 10.0 (Cheetah)'
    end

    it "should know the code name for Mac OS X 10.0" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Mac OS X', 'major' => '10', 'minor' => '0', 'patch' => 2 } }).os.should == 'Apple Mac OS X 10.0.2 (Cheetah)'
    end

    it "should know the code name for Mac OS X 10.1" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Mac OS X', 'major' => '10', 'minor' => '1', 'patch' => 2 } }).os.should == 'Apple Mac OS X 10.1.2 (Puma)'
    end

    it "should know the code name for Mac OS X 10.2" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Mac OS X', 'major' => '10', 'minor' => '2', 'patch' => 2 } }).os.should == 'Apple Mac OS X 10.2.2 (Jaguar)'
    end

    it "should know the code name for Mac OS X 10.3" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Mac OS X', 'major' => '10', 'minor' => '3', 'patch' => 2 } }).os.should == 'Apple Mac OS X 10.3.2 (Panther)'
    end

    it "should know the code name for Mac OS X 10.4" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Mac OS X', 'major' => '10', 'minor' => '4', 'patch' => 2 } }).os.should == 'Apple Mac OS X 10.4.2 (Tiger)'
    end

    it "should know the code name for Mac OS X 10.5" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Mac OS X', 'major' => '10', 'minor' => '5', 'patch' => 2 } }).os.should == 'Apple Mac OS X 10.5.2 (Leopard)'
    end

    it "should know the code name for Mac OS X 10.6" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Mac OS X', 'major' => '10', 'minor' => '6', 'patch' => 2 } }).os.should == 'Apple Mac OS X 10.6.2 (Snow Leopard)'
    end

    it "should know the code name for Mac OS X 10.7" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Mac OS X', 'major' => '10', 'minor' => '7', 'patch' => '2' } }).os.should == 'Apple Mac OS X 10.7.2 (Lion)'
    end

    it "should provide a generic os/version for other operating systems" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Linux', 'major' => '2', 'minor' => '6', 'patch' => '32' } }).os.should == 'Linux 2.6.32'
    end

    it "should provide a generic os name without version" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'FreeBSD' } }).os.should == 'FreeBSD'
    end
  end

  it "should combing operating system and browser version" do
    ua = UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Mac OS X', 'major' => '10', 'minor' => '7', 'patch' => '2' }, 'user_agent' => { 'family' => 'Chrome', 'major' => '14', 'minor' => '0', 'patch' => '835' } })
    ua.browser_family.should == 'Chrome'
    ua.browser_version.should == '14.0.835'
    ua.os_family.should == 'Mac OS X'
    ua.os_version.should == '10.7.2'
  end
end