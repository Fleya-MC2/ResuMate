//
//  FirstResume.swift
//  ResuMate
//
//  Created by Pahala Sihombing on 10/06/23.
//

import SwiftUI

struct FirstResume: View {
    @State private var textHeight: CGFloat = .zero

    var body: some View {
        VStack{
            VStack {
                Text("Caca Merica")
                    .fontWeight(.bold)
                    .font(.system(size: 13))
                Text("cacamerica@gmail.com | +62123456789 | Jakarta, Indonesia")
                    
                    .font(.system(size: 10))
            }
           
            JustifiedText(
                height: $textHeight,
                text: "Lorem ipsum dolor Lorem ipsum dolorLorem ipsum kkokoknlokok hgjk jhkkhkh h  dolorLorem ipdssum dolorLorem ipsum dsf dolorLorem icxpsumj ijidsj jijdsij doldsorLorem nkk ipssdum dolorLorem nknknkipsum dcdsdadasdsadasdsoem ipsum dolorLorem ipsum dolfd fd sdf,lmllucvvm fds ffd sd sfds sfd  sdf sdf sd fl df  f dsf df sd df sdf d ksdsfds f dsf ds lfds  nj jnjsdffkhulub sdbksj d sdsda fksd fkjdsbfj jsjddkjksjf odsrLorem ipsum dolorLdsoresdm ipsum dolorLorem ipsum dolordsLorem ipsum dolordwdw dwad d kdqwhdelqw.")
                .frame(height: textHeight)
                .font(.system(size: 10))
            VStack {
                HStack {
                    ResumeTitleText(text:"PENGALAMAN KERJA")
                }
                Divider()
                    .frame(height: 1)
                .background(.black)
                VStack {
                    HStack{
                        ResumeSubtitleText(text: "Admin Perkantoran, Perusahaan ABC")
                        Spacer()
                        ResumeSubtitleText(text: "September 2020 - Sekarang")
                    }
                    VStack{
                        ResumeDetailText(text: "- Mengelola daftar gaji ")
                        ResumeDetailText(text: "- Berkomunikasi bersama manager")
                    }
                }
                VStack {
                    HStack{
                        ResumeSubtitleText(text: "Admin Perkantoran, Perusahaan 123")
                        Spacer()
                        ResumeSubtitleText(text: "September 2015 - September 2020")
                    }
                    VStack{
                        ResumeDetailText(text: "- Mengelola daftar gaji")
                        ResumeDetailText(text: "- Berkomunikasi bersama manager")
                    }
                }

            }
            .padding(.top)
            VStack {
                HStack {
                    ResumeTitleText(text:"PENDIDIKAN")
                }
                Divider()
                    .frame(height: 1)
                .background(.black)
                VStack {
                    HStack{
                        ResumeSubtitleText(text: "S1 Manajemen, Universitas ABC")
                        Spacer()
                        ResumeSubtitleText(text: "Agustus 2014 - Maret 2018")
                    }
                    VStack{
                        ResumeDetailText(text: "- IPK 3,65 ")
                    }
                }
                VStack {
                    HStack{
                        ResumeSubtitleText(text: "SMA IPS, SMA ABC")
                        Spacer()
                        ResumeSubtitleText(text: "September 2015 - September 2020")
                    }
                    VStack{
                        ResumeDetailText(text: "- Nilai Akhir = 84,78")
                        ResumeDetailText(text: "- Sekretaris OSIS 2013/2014")
                    }
                }

            }
            .padding(.top)
            VStack {
                ResumeTitleText(text:"PENGALAMAN ORGANISASI")
                
                Divider()
                .frame(height: 1)
                .background(.black)
                VStack {
                    HStack{
                        ResumeSubtitleText(text: "Sekretaris Jendral, Organisasi ABC")
                        Spacer()
                        ResumeSubtitleText(text: "September 2020 - Desember 2021")
                    }
                    VStack{
                        ResumeDetailText(text: "- Mengelola daftar gaji ")
                        ResumeDetailText(text: "- Berkomunikasi bersama manager")
                    }
                }
                VStack {
                    HStack{
                        ResumeSubtitleText(text: "Admin Perkantoran, Perusahaan 123")
                        Spacer()
                        ResumeSubtitleText(text: "September 2015 - September 2020")
                    }
                    VStack{
                        ResumeDetailText(text: "- Mengelola daftar gaji")
                        ResumeDetailText(text: "- Berkomunikasi bersama manager")
                    }
                }

            }
            .padding(.top)
            VStack {
                ResumeTitleText(text:"PENGHARGAAN")
                
                Divider()
                .frame(height: 1)
                .background(.black)
                VStack {
                    HStack{
                        ResumeSubtitleText(text: "- Penerima Beasiswa ABC")
                        Spacer()
                        ResumeSubtitleText(text: "2021")
                    }
                    VStack{
                        ResumeDetailText(text: "  Terpilih sebagai salah satu penerima dari 500 orang")
                    }
                }
                VStack {
                    HStack{
                        ResumeSubtitleText(text: "- Juara Pertama Lomba Bussiness Plan")
                        Spacer()
                        ResumeSubtitleText(text: "2020")
                    }
                    VStack{
                        ResumeDetailText(text: "   Pemenang utama Lomba Statistika")
                    }
                }

            }
            .padding(.top)
            VStack {
                ResumeTitleText(text:"KETERAMPILAN")
                
                Divider()
                .frame(height: 1)
                .background(.black)
                VStack{
                    HStack{
                    ResumeSubtitleText(text: "Soft Skill :")
                    Spacer()
                    }
                    HStack{
                        VStack{
                            ResumeDetailText(text: "- Kemampuan manajemen waktu")
                            ResumeDetailText(text: "- Kemampuan berorganisasi")
                            ResumeDetailText(text: "- Komunikasi")
                        }
                        VStack{
                            
                            ResumeDetailText(text: "- Kemampuan menjalin relasi")
                            ResumeDetailText(text: "- Kemampuan analisis")
                        }
                    }
                }
                VStack{
                    HStack{
                    ResumeSubtitleText(text: "Hard Skill :")
                    Spacer()
                    }
                    HStack{
                        VStack{
                            ResumeDetailText(text: "- MS Excel")
                            ResumeDetailText(text: "- MS Powerpoint")
                            ResumeDetailText(text: "- MS Word")
                        }
                        
                    }
                }

            }
            .padding(.top)
            Text("")
            Spacer()

                
        }

        .padding()
    }
}

struct FirstResume_Previews: PreviewProvider {
    static var previews: some View {
        FirstResume()
    }
}
