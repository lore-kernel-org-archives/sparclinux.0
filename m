From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 01 Jan 2018 21:42:45 +0000
Subject: Re: [sparc64] kernel unaligned access at TPC aa_dfa_unpack
Message-Id: <20180101214245.GA9827@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqwo8sL3RtEWRMcHkgkSAnWKeVibLRrtdXU2e8w2Q5KSTQ@mail.gmail.com>
In-Reply-To: <CADxRZqwo8sL3RtEWRMcHkgkSAnWKeVibLRrtdXU2e8w2Q5KSTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-security-module@vger.kernel.org

Hi Anatoly.

On Tue, Jan 02, 2018 at 12:11:49AM +0300, Anatoly Pugachev wrote:
> Hello!
> 
> Using latest git kernel (4.15.0-rc6) , getting the following messages
> on LDOM/kernel boot:
> 
> [    7.693653] Kernel unaligned access at TPC[7496d8] aa_dfa_unpack+0x38/0x580
> [    7.693735] Kernel unaligned access at TPC[7496f8] aa_dfa_unpack+0x58/0x580
> [    7.693782] Kernel unaligned access at TPC[749708] aa_dfa_unpack+0x68/0x580
> [    7.693829] Kernel unaligned access at TPC[74973c] aa_dfa_unpack+0x9c/0x580
> [    7.693875] Kernel unaligned access at TPC[749758] aa_dfa_unpack+0xb8/0x580
> [    7.697135] audit: type00 audit(1514840016.480:2):
> apparmor="STATUS" operation="profile_load" profile="unconfined"
> name="/usr/sbin/tcpdump" pidP7 comm="apparmor_parser"
> 
> 
> Can someone please look, what could cause unaligned access at this
> aa_dfa_unpack function/structure ?

A quick guess would be that you are using nulldfa.
And this variable may not be aligned.

Try to check the address of nulldfa_src.

You could also try to force the compiler to align the data
to 8 byte like this (security/apparmor/match.c):

static char nulldfa_src[] = {
        #include "nulldfa.in"
} __aligned(8);  		<= see the added __aligned(8)

This is just from a quick look at things, but please try it to
see if this is the problematic spot.

	Sam
