From: Anatoly Pugachev <matorola@gmail.com>
Date: Sat, 10 Feb 2018 08:10:11 +0000
Subject: Re: [sparc64] kernel unaligned access at TPC aa_dfa_unpack
Message-Id: <CADxRZqySeF_3ZK7vJjJ9XW1buiRd6sesOGBF-Skj6qV8xevZ_A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqwo8sL3RtEWRMcHkgkSAnWKeVibLRrtdXU2e8w2Q5KSTQ@mail.gmail.com>
	<CADxRZqyTE5xFm+Fs-iR2Xjb4JHiVdGma+iyKwtBoU-RtBFf0qg@mail.gmail.com>
In-Reply-To: <CADxRZqyTE5xFm+Fs-iR2Xjb4JHiVdGma+iyKwtBoU-RtBFf0qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-security-module@vger.kernel.org

On Sun, Jan 21, 2018 at 10:41 PM, Anatoly Pugachev <matorola@gmail.com> wrote:
> On Tue, Jan 2, 2018 at 12:11 AM, Anatoly Pugachev <matorola@gmail.com> wrote:
>> Hello!
>>
>> Using latest git kernel (4.15.0-rc6) , getting the following messages
>> on LDOM/kernel boot:
>>
>> [    7.693653] Kernel unaligned access at TPC[7496d8] aa_dfa_unpack+0x38/0x580
>> [    7.693735] Kernel unaligned access at TPC[7496f8] aa_dfa_unpack+0x58/0x580
>> [    7.693782] Kernel unaligned access at TPC[749708] aa_dfa_unpack+0x68/0x580
>> [    7.693829] Kernel unaligned access at TPC[74973c] aa_dfa_unpack+0x9c/0x580
>> [    7.693875] Kernel unaligned access at TPC[749758] aa_dfa_unpack+0xb8/0x580

https://bugzilla.kernel.org/show_bug.cgi?id8743
