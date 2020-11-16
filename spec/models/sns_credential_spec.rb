require 'rails_helper'

  describe SnsCredential do
    describe '#facebook' do
      it "providerがない場合は登録できないこと" do
        sns_credential = build(:sns_credential, provider: "")
        sns_credential.valid?
        expect(sns_credential.errors[:provider]).to include("を入力してください")
      end

      it "uidがない場合は登録できないこと" do
        sns_credential = build(:sns_credential, uid: "")
        sns_credential.valid?
        expect(sns_credential.errors[:uid]).to include("を入力してください")
      end

      it "provider, uidが存在すれば登録出来ること" do
        sns_credential = build(:sns_credential)
        expect(sns_credential).to be_valid
      end
    end

    describe '#google_oauth2' do
      it "providerがない場合は登録できないこと" do
        sns_credential = build(:sns_credential, provider: "")
        sns_credential.valid?
        expect(sns_credential.errors[:provider]).to include("を入力してください")
      end

      it "uidがない場合は登録できないこと" do
        sns_credential = build(:sns_credential, uid: "")
        sns_credential.valid?
        expect(sns_credential.errors[:uid]).to include("を入力してください")
      end

      it "provider, uidが存在すれば登録出来ること" do
        sns_credential = build(:sns_credential)
        expect(sns_credential).to be_valid
      end
    end

  end
