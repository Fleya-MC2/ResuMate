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
            
            // BIODATA
            
            VStack {
                Text("Caca Merica")
                    .fontWeight(.bold)
                    .font(.system(size: 13))
                Text("cacamerica@gmail.com | +62123456789 | Jakarta, Indonesia")
                    
                    .font(.system(size: 10))
            }
           
            JustifiedText(
                height: $textHeight,
                text: "Caca Merica adalah seorang admin perkantoran dengan pengalaman 3+ tahun. Beliau juga memiliki ketrampilan organisasi, manajemen waktu, administrasi, dan keuangan yang luar biasa. Keterampilan tersebut terbukti oleh pengalaman dia di berbagai perusahaan seperti meningkatkan efisiensi Kantor Perusahaan ABC sebesar 15% melalui keahlian pada software manajemen kantor",
                fontSize: 10
            )
                .frame(height: textHeight)
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
                    HStack(alignment: .top) {
                        VStack {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 4))
                                .padding(.top, 11)
                        }
                        JustifiedText(height: $textHeight, text: "﻿MEngelola dafar gajisdaas kalsdjnasd",fontSize: 8
                        )
                        .frame(height: textHeight)
                    }
                    HStack(alignment: .top) {
                        VStack {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 4))
                                .padding(.top, 11)
                        }
                        JustifiedText(height: $textHeight, text: "﻿Berkomunikasi bersama ketua",fontSize: 8
                        )
                        .frame(height: textHeight)
                    }
                }
                VStack {
                    HStack{
                        ResumeSubtitleText(text: "Admin Perkantoran, Perusahaan 123")
                        Spacer()
                        ResumeSubtitleText(text: "September 2015 - September 2020")
                    }
                    HStack(alignment: .top) {
                        VStack {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 4))
                                .padding(.top, 11)
                        }
                        JustifiedText(height: $textHeight, text: "﻿MEngelola dafar gajisdaas kalsdjnasd",fontSize: 8
                        )
                        .frame(height: textHeight)
                    }
                    HStack(alignment: .top) {
                        VStack {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 4))
                                .padding(.top, 11)
                        }
                        JustifiedText(height: $textHeight, text: "﻿Berkomunikasi bersama ketua",fontSize: 8
                        )
                        .frame(height: textHeight)
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
                            .frame(maxWidth: .infinity, alignment: .leading)
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
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ResumeDetailText(text: "- Sekretaris OSIS 2013/2014")
                            .frame(maxWidth: .infinity, alignment: .leading)
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
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ResumeDetailText(text: "- Berkomunikasi bersama manager")
                            .frame(maxWidth: .infinity, alignment: .leading)
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
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ResumeDetailText(text: "- Berkomunikasi bersama manager")
                            .frame(maxWidth: .infinity, alignment: .leading)
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
                            .frame(maxWidth: .infinity, alignment: .leading)
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
                            .frame(maxWidth: .infinity, alignment: .leading)
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
                                .frame(maxWidth: .infinity, alignment: .leading)
                            ResumeDetailText(text: "- Kemampuan berorganisasi")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            ResumeDetailText(text: "- Komunikasi")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        
                        VStack{
                            
                            ResumeDetailText(text: "- Kemampuan menjalin relasi")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            ResumeDetailText(text: "- Kemampuan analisis")
                                .frame(maxWidth: .infinity, alignment: .leading)
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
                                .frame(maxWidth: .infinity, alignment: .leading)
                            ResumeDetailText(text: "- MS Powerpoint")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            ResumeDetailText(text: "- MS Word")
                                .frame(maxWidth: .infinity, alignment: .leading)
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
