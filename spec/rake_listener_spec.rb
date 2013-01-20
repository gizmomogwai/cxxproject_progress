require 'cxxproject'
require 'cxxproject_progress/rake_listener.rb'
require 'cxxproject/utils/cleanup'

describe Rake::Task do

  before(:each) do
    Cxxproject::Utils.cleanup_rake
    @t1 = task "mypre"
    @t2 = task "test" => "mypre"
  end
  after(:each) do
    Cxxproject::Utils.cleanup_rake
  end


  it "should call a listener for prerequisites and execute" do
    l = mock
    Rake::add_listener(l)

    l.should_receive(:before_prerequisites).with('test').ordered
    l.should_receive(:before_prerequisites).with('mypre').ordered
    l.should_receive(:after_prerequisites).with('mypre').ordered
    l.should_receive(:before_execute).with('mypre').ordered
    l.should_receive(:after_execute).with('mypre').ordered
    l.should_receive(:after_prerequisites).with('test').ordered
    l.should_receive(:before_execute).with('test').ordered
    l.should_receive(:after_execute).with('test').ordered
    @t2.invoke

    Rake::remove_listener(l)
  end

  it 'should not receive callbacks after remove' do
    l = mock
    Rake::add_listener(l)
    Rake::remove_listener(l)
    @t2.invoke
  end

  it 'should call not more than expected' do
    l = mock
    l.should_receive(:before_prerequisites).with('mypre').ordered
    l.should_receive(:after_prerequisites).with('mypre').ordered
    l.should_receive(:before_execute).with('mypre').ordered
    l.should_receive(:after_execute).with('mypre').ordered

    l.should_receive(:before_prerequisites).with('test').ordered
    l.should_receive(:after_prerequisites).with('test').ordered
    l.should_receive(:before_execute).with('test').ordered
    l.should_receive(:after_execute).with('test').ordered

    Rake::add_listener(l)
    @t1.invoke
    @t1.invoke

    @t2.invoke
    Rake::remove_listener(l)
  end

  class DummyListener
    def calls
      @calls ||= []
    end
    def after_execute(name)
      c = calls
      c << name
    end
  end

  it "should work with only half implemented rake-listener" do
    l = DummyListener.new
    Rake::add_listener(l)
    @t2.invoke
    Rake::remove_listener(l)
    l.calls.should eq(['mypre', 'test'])
  end

end
