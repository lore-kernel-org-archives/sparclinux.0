From: Jim Watson <jim@amarooas.com.au>
Date: Thu, 19 Oct 2006 06:38:41 +0000
Subject: Re: Problems booting 2.6.18 on SunBlade 100/150
Message-Id: <BF7604C6-4086-4238-96F2-3998BA60D58C@amarooas.com.au>
List-Id: <sparclinux.vger.kernel.org>
References: <200401070729.56891.pkarlsen@mandriva.com>
In-Reply-To: <200401070729.56891.pkarlsen@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 19/10/2006, at 5:30 AM, David Miller wrote:
>
> Are you sure you're enabling ATYFB video support in your kernel?
> That's a common error when folks build their own kernels.

Success! I used the later patch [0] and the config file from debian  
2.6.18-1-sparc64 as mentioned by Jurij[1]
which includes - hopefully relevant ;)

CONFIG_FB_ATY128=y
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
# CONFIG_FB_ATY_GENERIC_LCD is not set
CONFIG_FB_ATY_GX=y

Using LCD Benq FP767 here,

I could only get it it to boot this way:

boot:mylinux18 video=atyfb:off

which is what I need as it also gets rid of those pesky red dots ;)

I am happy to report anything else that might assist...

thanks to David for the patches and thanks to Jurij for guidance,

jim

[0] http://marc.theaimsgroup.com/?l=linux-sparc&m6120447318793&w=2
[1] http://marc.theaimsgroup.com/?l=linux-sparc&m6120045100433&w=2
