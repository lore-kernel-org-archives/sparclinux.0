From: Chris Newport <crn@netunix.com>
Date: Thu, 03 Mar 2005 23:21:15 +0000
Subject: Re: [PATCH] sparc: fix compile failure ("struct resource" related)
Message-Id: <42279BEB.5060609@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20050301134440.05ae1152.akpm@osdl.org>
In-Reply-To: <20050301134440.05ae1152.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Dennis Jenkins wrote:

>>The soc/pluto stuff has not been maintained since
>>2.2.x and AFAIK this 
>>is also true for socal.
>>    
>>
>
>Yup, I read that too.  And immediately there after I
>downloaded the last 2.2 kernel and tried to compile
>it.  Unfortunately for me, GCC 3.3.5 choked heavily on
>it.  I will try again when I figure out how to get
>Gentoo to downgrade gcc.  The question is, what
>version should I downgrade to?
>  
>
I have no idea about Gentoo versions, but Splack 8.0 has a working 2.2 
kernel with soc and socal modules. Everything you need to experiment 
with 2.4 is there, but the toolset and compiler are too old for 2.6
In general, you should not need to have the Sun firmware in your
drivers, just upload them to the card and array from Solaris and they
will stay there in nvram. This avoids contaminating Linux with Sun's code.
The procedure for socal is similar to my procedure for soc, take a look 
at the Solaris man pages for luxadm etc.


