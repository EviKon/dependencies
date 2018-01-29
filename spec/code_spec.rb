require 'code'

RSpec.describe Code do
  let(:input) { 'a=> ' }
  let(:instance) { Code.new(input) }

  describe '#jobs' do
    subject { instance.jobs }

    it 'returns a hash of the input string' do
      expect(subject).to eql('a')
    end

    context 'when the input has more than one dependencies' do
      let(:input) { 'a=> ,b=> ' }

      it 'returns a hash of the input string with multiple keys' do
        expect(subject).to eql('ab')
      end
    end

    context '' do
      let(:input) { 'a=>c,b=>d' }

      it 'returns the output with the values before the keys' do
        expect(subject).to eql('cadb')
      end
    end

    context 'when the input has dependencies on other keys' do
      let(:input) { 'a=> ,b=>c,c=> ' }

      it 'returns the output with the jobs in the right order' do
        expect(subject).to eql('acb')
      end
    end

    context 'when the input has multiple dependencies' do
      let(:input) { 'a=> ,b=>c,c=>f,d=>a,e=>b,f=> ' }

      it 'returns the output with the jobs in the right order' do
        expect(subject).to eql('afcbde')
      end
    end

    context 'when the input contains a self dependency' do
      let(:input) { 'a=> ,b=> ,c=>c' }

      it 'raises an error for self dependencies' do
        expect{ subject }.to raise_error "There can not be self dependencies"
      end
    end

    context 'when the input contains a circular dependency' do
      let(:input) { 'a=> ,b=>c,c=>f,d=>a,e=> ,f=>b' }

      it 'raises an error for circular dependencies' do
        expect{ subject }.to raise_error "There can not be circular dependencies"
      end
    end
  end
end
