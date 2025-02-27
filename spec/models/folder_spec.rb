require 'rails_helper'

RSpec.describe Folder, type: :model do
  it 'has a valid factory' do
    expect(build(:folder)).to be_valid
  end

  describe 'associations' do
    let(:folder) { build(:folder) }

    it { expect(folder).to belong_to(:parent).required(false) }
    it { expect(folder).to have_many(:subfolders) }
    it { expect(folder).to have_many(:documents) }
  end

  describe 'validations' do
    let(:folder) { build(:folder) }

    it { expect(folder).to validate_presence_of(:name) }
    it { expect(folder).to validate_length_of(:name).is_at_most(255) }
    it { expect(folder).to validate_uniqueness_of(:name).scoped_to(:folder_id).case_insensitive }
  end

  describe 'public methods' do
    let!(:folder) { create(:folder, :with_documents_and_subfolders) }

    it 'list folder items' do
      expect(folder.items).to eq(folder.subfolders + folder.documents)
    end
  end
end
