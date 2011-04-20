From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 20 Apr 2011 10:44:07 +0000
Subject: Re: [PATCH 6/7] sparc32,leon: operate on boot-cpu IRQ controller
Message-Id: <20110420104407.GA32481@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1303229239-21551-6-git-send-email-daniel@gaisler.com>
In-Reply-To: <1303229239-21551-6-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Apr 20, 2011 at 11:38:26AM +0200, Josip Rodin wrote:
> On Wed, Apr 20, 2011 at 11:06:54AM +0200, Sam Ravnborg wrote:
> > [PATCH]sparc32: always define boot_cpu_id
> > 
> > +extern unsigned char boot_cpu_id;
> > +unsigned char boot_cpu_id;
> > -unsigned char boot_cpu_id = 0;
> > -	int target_cpu = 0;
> > +	int target_cpu;
> >  	target_cpu = boot_cpu_id;
> 
> You declared it, but you didn't actually define it?

It is defined in setup_32.c

	Sam
