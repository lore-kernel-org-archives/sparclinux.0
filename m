From: Jurij Smakov <jurijus@wooyd.org>
Date: Wed, 24 May 2006 04:33:25 +0000
Subject: Re: 2.6.17-rc3+git seems to corrupt dpkg databases
Message-Id: <Pine.LNX.4.63.0605232128440.3273@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0605151108040.27015@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0605151108040.27015@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 23 May 2006, Meelis Roos wrote:

>>  Some further testing has narrowed it down to
>>  2.6.17-rc1-g676165a8 probably OK (debian apt-get upgrade succeeded)
>>  2.6.17-rc2 bad (first package broke dpkg status file)
>
> 2.6.17-rc1-gc19f7a9e from Apr 17 seems also OK,
> 2.6.17-rc2 from Apr 19 is bad.
>
> Enough testing for today.

Thanks for all your work, Meelis!

FWIW, I have just reproduced the problem on my Ultra5 running 2.6.17-rc4 
by trying to install KDE and all dependencies :-(.

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
