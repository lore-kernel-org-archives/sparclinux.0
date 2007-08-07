From: "jiaqi zhang" <zation.busy@gmail.com>
Date: Tue, 07 Aug 2007 01:34:22 +0000
Subject: Re: SIGSEGV information on SPARC64
Message-Id: <a8e8903d0708061834s2ed916cbtc109bd39e0be4e7b@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a8e8903d0708061541r2b6f2dcxa1a2f143db3a026b@mail.gmail.com>
In-Reply-To: <a8e8903d0708061541r2b6f2dcxa1a2f143db3a026b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Do you mean retrieving the instruction from tpc in sigcontext?
Thanks a lot. I'll try it.

On 8/7/07, David Miller <davem@davemloft.net> wrote:
> From: "jiaqi zhang" <zation.busy@gmail.com>
> Date: Tue, 7 Aug 2007 10:41:18 +1200
>
> > While I could find the faultive address in siginfo_t, it seems there
> > is no way to find the access type(read or write) in it.
>
> Disassemble the instruction and see if it is a load or a store.
>
> Even if the information is added to siginfo_t, you'll need to make
> your code work on 10+ years of existing kernels.
>
