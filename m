From: "J.O. Aho" <trizt@iname.com>
Date: Wed, 07 Dec 2005 21:22:42 +0000
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
Message-Id: <Pine.LNX.4.64.0512072217580.24376@lai.local.lan>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0512061658190.14952@lai.local.lan>
 <20051206.152316.82233251.davem@davemloft.net>
 <Pine.LNX.4.64.0512071203460.8861@localhost.localdomain>
 <20051207.123458.26771065.davem@davemloft.net>
In-Reply-To: <20051207.123458.26771065.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel maillist <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

On Wed, 7 Dec 2005, David S. Miller wrote:

> From: "J.O. Aho" <trizt@iname.com>
> Date: Wed, 7 Dec 2005 12:05:43 +0100 (CET)
>
>> When running in plain console (without trying to run X) everything works
>> fine (just telling that so I won't get people to ask if ps segfaults in
>> other cases or claims that my init is broke and so on).
>
> Is the Xorg.conf setup to use the "ati" driver?  You can't use
> "fbdev" or similar, that will in fact hang the machine in a
> manner similar to how you describe.

I'm using the sunffb driver, as I wish to get the output from my creator3d 
card, so that I can see something displayed as the monitor requiers a 13W3 
connector. So I assume from your reply that framebuffer isn't working in 
kernel 2.6 for sparc, but for other archs like ppc?

-- 
      //Aho

  ------------------------------------------------------------------------
   E-Mail: trizt@iname.com            URL: http://www.kotiaho.net/~trizt/
      ICQ: 13696780
   System: Linux System                        (PPC7447/1000 AMD K7A/2000)
  ------------------------------------------------------------------------
             EU forbids you to send spam without my permission
  ------------------------------------------------------------------------
