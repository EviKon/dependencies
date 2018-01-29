require 'code'

RSpec.describe Code do
  let(:input) { 'a=> ' }
  let(:instance) { Code.new(input) }

  describe '#convert_to_hash' do
    subject { instance.convert_to_hash }

    it 'returns a hash of the input string' do
      expect(subject).to eql({ 'a' => ' '})
    end

    context 'when the input has more than one dependencies' do
      let(:input) { 'a=> ,b=> ' }

      it 'returns a hash of the input string with multiple keys' do
        expect(subject).to eql({ 'a' => ' ', 'b'=> ' ' })
      end
    end
  end

  describe '#iterate_the_hash_with_keys' do
    subject { instance.iterate_the_hash }

    it 'returns every the key of the hash in a string' do
      expect(subject).to eql('a')
    end

    context 'when the input has more than one dependencies' do
      let(:input) { 'a=> ,b=> ' }

      it 'returns every the key of the hash in a string' do
        expect(subject).to eql('ab')
      end
    end
  end

  describe '#iterate_the_hash_with_keys_and_values' do
    let(:input) { 'a=>c,b=>d' }
    subject { instance.iterate_the_hash_with_keys_and_values }

    it 'returns the output with the values before the keys' do
      expect(subject).to eql('cadb')
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
  end
end