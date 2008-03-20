From: David Miller <davem@davemloft.net>
Date: Thu, 20 Mar 2008 22:13:38 +0000
Subject: Re: sound/sparc/dbri.c: snd_dbri_pcm(): strcpy(pcm->name,
Message-Id: <20080320.151338.126627719.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <47E29A61.40008@tiscali.nl>
In-Reply-To: <47E29A61.40008@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Roel Kluin <12o3l@tiscali.nl>
Date: Thu, 20 Mar 2008 18:09:53 +0100

> from sound/sparc/dbri.c:2233:
> 
> strcpy(pcm->name, card->shortname);
> 
> shouldn't that be 'strcpy(card->shortname, pcm->name)'?

Just like the NIU case your analysis is inaccurate.

strcpy() copies the second argument string to the first argument's
string area.

dbri_probe() sets pcm->shortname, and here we are propagating that
string to pcm->name
