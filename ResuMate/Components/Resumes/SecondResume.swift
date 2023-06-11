//
//  SecondResume.swift
//  ResuMate
//
//  Created by Pahala Sihombing on 10/06/23.
//

import SwiftUI


struct SecondResume: View {
    @State private var textHeight: CGFloat = .zero

    var body: some View {
        VStack{
            
            VStack {
                HStack {
                    Text("First Last")
                        .fontWeight(.bold)
                        .font(.system(size: 17))
                    Spacer()
                }
                HStack {
                    Text("firstlast@resumate.com | +1 (123) 456789 | San Fransisco, CA")
                        .font(.system(size: 10))
                    Spacer()
                }
            }
            
            VStack {
                HStack {
                    ResumeTitleText(text:"EXPERIENCE")
                }
                Divider()
                    .frame(height: 1)
                .background(.black)
                VStack {
                    HStack{
                        ResumeSubtitleText(text: "ResuMate & Co.")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ResumeSubtitleText(text: "Oct 2017 - Present")
                            .multilineTextAlignment(.trailing)
                    }
                    HStack{
                        ResumeDetailText(text: "Senior Analyst, Business Development & Operations")
                        Spacer()
                        ResumeDetailText(text: "San Fransisco, CA")

                    }
                    VStack{
                        HStack(alignment: .top) {
                            VStack {
                                Image(systemName: "circle.fill")
                                    .font(.system(size: 4))
                                    .padding(.top, 11)
                            }
                            JustifiedText(height: $textHeight, text: "Managed cross-functional team of 10 in 3 locations (Palo Alto, Austin and New York), ranging from entry-level analysts to vice presidents, and collaborated with business development, data analysis, operations and marketing",fontSize: 8
                            )
                            .frame(height: textHeight)
                        }
                        HStack(alignment: .top) {
                            
                            Spacer(minLength: 15)
                            VStack {
                                Image(systemName: "circle")
                                    .font(.system(size: 4))
                                    .padding(.top, 11)
                            }
                            JustifiedText(height: $textHeight, text: "﻿Launched Miami office with lead Director and recruited and managed new team of 10 employees; grew office revenue by 200% in first nine months (representing 20% of company revenue",fontSize: 8
                            )
                            .frame(height: textHeight)
                        }
                        HStack(alignment: .top) {
                            
                            Spacer(minLength: 15)
                            VStack {
                                Image(systemName: "circle")
                                    .font(.system(size: 4))
                                    .padding(.top, 11)
                            }
                            JustifiedText(height: $textHeight, text: "﻿Designed training and peer-mentoring programs for the incoming class of 25 analysts in 2017; reduced onboarding time for new hires by 50%",fontSize: 8
                            )
                            .frame(height: textHeight)
                        }
                        HStack(alignment: .top) {
                            VStack {
                                Image(systemName: "circle.fill")
                                    .font(.system(size: 4))
                                    .padding(.top, 11)
                            }
                            JustifiedText(height: $textHeight, text: "Led the transition to a paperless practice by implementing an electronic booking system and a faster, safer and more accurate business system; reduced cost of labor by 30% and office overhead by 10%",fontSize: 8
                            )
                            .frame(height: textHeight)
                        }
                        HStack(alignment: .top) {
                            VStack {
                                Image(systemName: "circle.fill")
                                    .font(.system(size: 4))
                                    .padding(.top, 11)
                            }
                            JustifiedText(height: $textHeight, text: "﻿Notes: Your most recent experience should have the most detail; avoid using more than 6 bullet points per experience; if you have accomplished a lot at one company and have more than 6 bullets, split them up into job titles at the same company",fontSize: 8
                            )
                            .frame(height: textHeight)
                        }
                        
                    }
                }
                VStack {
                    VStack {
                        HStack{
                            ResumeSubtitleText(text: "Instamake")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            ResumeSubtitleText(text: "June 2015 - Oct 2017")
                                .multilineTextAlignment(.trailing)
                        }
                        HStack{
                            ResumeDetailText(text: "Associate Product Manager")
                            Spacer()
                            ResumeDetailText(text: "San Fransisco, CA")

                        }
                        VStack{
                            HStack(alignment: .top) {
                                VStack {
                                    Image(systemName: "circle.fill")
                                        .font(.system(size: 4))
                                        .padding(.top, 11)
                                }
                                JustifiedText(height: $textHeight, text: "Spearheaded a major pricing restructure by redirecting focus on consumer willingness to pay instead of product cost; implemented a three-tiered pricing model which increased average sale 35% and margin 12%",fontSize: 8
                                )
                                .frame(height: textHeight)
                            }


                            HStack(alignment: .top) {
                                VStack {
                                    Image(systemName: "circle.fill")
                                        .font(.system(size: 4))
                                        .padding(.top, 11)
                                }
                                JustifiedText(height: $textHeight, text: "Promoted within 12 months due to strong performance and organizational impact (1 year ahead of schedule )",fontSize: 8
                                )
                                .frame(height: textHeight)
                            }
                            HStack(alignment: .top) {
                                VStack {
                                    Image(systemName: "circle.fill")
                                        .font(.system(size: 4))
                                        .padding(.top, 11)
                                }
                                JustifiedText(height: $textHeight, text: "Identified steps to reduce return rates by 10% resulting in an eventual $75k cost savings",fontSize: 8
                                )
                                .frame(height: textHeight)
                            }
                            
                        }
                    }
                    VStack {
                        HStack{
                            ResumeSubtitleText(text: "ResuMate & Co.")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            ResumeSubtitleText(text: "June 2011 - May 2013")
                                .multilineTextAlignment(.trailing)
                        }
                        HStack{
                            ResumeDetailText(text: "Associate Product Manager")
                            Spacer()
                            ResumeDetailText(text: "Austin, TX")

                        }
                        VStack{
                            HStack(alignment: .top) {
                                VStack {
                                    Image(systemName: "circle.fill")
                                        .font(.system(size: 4))
                                        .padding(.top, 11)
                                }
                                JustifiedText(height: $textHeight, text: "Analyzed data from 25000 monthly active users and used outputs to guide marketing and product strategies, increased app engagement time by 2x, 30% deccrease in drop off rate, and3x shares on social media",fontSize: 8
                                )
                                .frame(height: textHeight)
                            }


                            HStack(alignment: .top) {
                                VStack {
                                    Image(systemName: "circle.fill")
                                        .font(.system(size: 4))
                                        .padding(.top, 11)
                                }
                                JustifiedText(height: $textHeight, text: "Spearheaded redevelopment of internal tracking system in use by 125 employees, resulting in 20+ new features, reduction of 20% in save/load time and 15% operation time",fontSize: 8
                                )
                                .frame(height: textHeight)
                            }                            
                        }
                    }


                }

            }
            .padding(.top)
            VStack {
                HStack {
                    ResumeTitleText(text:"EDUCATION")
                }
                Divider()
                    .frame(height: 1)
                .background(.black)
                VStack {
                    HStack{
                        ResumeSubtitleText(text: "ResuMate Business School")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ResumeSubtitleText(text: "May 2015")
                            .multilineTextAlignment(.trailing)
                    }
                    HStack{
                        ResumeDetailText(text: "Master of Business Administration Candidate; Major in Business Analytics")
                        Spacer()
                        ResumeDetailText(text: "Austin, TX")

                    }
                    VStack{
                        HStack(alignment: .top) {
                            VStack {
                                Image(systemName: "circle.fill")
                                    .font(.system(size: 4))
                                    .padding(.top, 11)
                            }
                            JustifiedText(height: $textHeight, text: "Awards: Bill & Melinda Gates Fellow (only 5 awarded to class), Director's List 2017 (top 10%)",fontSize: 8
                            )
                            .frame(height: textHeight)
                        }


                        HStack(alignment: .top) {
                            VStack {
                                Image(systemName: "circle.fill")
                                    .font(.system(size: 4))
                                    .padding(.top, 11)
                            }
                            JustifiedText(height: $textHeight, text: "Leadership: ResuMate Investment Club (Board Member), Consulting Club (Engagement Manager)",fontSize: 8
                            )
                            .frame(height: textHeight)
                        }
                    }
                }
                VStack {
                    HStack{
                        ResumeSubtitleText(text: "ResuMate University")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ResumeSubtitleText(text: "May 2011")
                            .multilineTextAlignment(.trailing)
                    }
                    HStack{
                        ResumeDetailText(text: "Master of Business Administration Candidate; Major in Business Analytics")
                        Spacer()
                        ResumeDetailText(text: "San Francisco, CA")

                    }
                    VStack{
                        HStack(alignment: .top) {
                            VStack {
                                Image(systemName: "circle.fill")
                                    .font(.system(size: 4))
                                    .padding(.top, 11)
                            }
                            JustifiedText(height: $textHeight, text: "Note: Your education section can be much shorter than this; only add bullet points to your education if they add value to your overall experience; prioritize accomplishments in your work experience",fontSize: 8
                            )
                            .frame(height: textHeight)
                        }
                    }
                }
            }
            VStack {
                ResumeTitleText(text:"OTHER")
                
                Divider()
                .frame(height: 1)
                .background(.black)

                VStack {
                    HStack(alignment: .top) {
                        VStack {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 4))
                                .padding(.top, 4)
                        }
                        ResumeSubtitleText(text: "Technical Skills: Salesforce CRM, MATLAB, Microsoft Project, add other keyword from job req")
                    }
                }
            }

            Text("")
            Spacer()
        }
        .padding()
    }
}

struct SecondResume_Previews: PreviewProvider {
    static var previews: some View {
        SecondResume()
    }
}
