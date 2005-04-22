From: Tomas Cernaj <tcernaj@gmx.de>
Date: Fri, 22 Apr 2005 18:38:08 +0000
Subject: Re: Weird Mouse Behaviour with 2.6
Message-Id: <1114195088.8937.3.camel@dingsto>
List-Id: <sparclinux.vger.kernel.org>
References: <20050421220834.6bb61f44.davem@davemloft.net>
In-Reply-To: <20050421220834.6bb61f44.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Am Donnerstag, den 21.04.2005, 22:08 -0700 schrieb David S. Miller:
> Ok, let's kill this bug already :-)
> 
> We were neglecting to invoke sunsu_change_speed() when first
> setting up the keyboard and mouse ports.  That's why things
> were not working.
> 
> This should fix it and I'll push this upsteam.
> 
> [SPARC64]: In sunsu driver, make sure to fully init chip for kbd/ms
> 
> We were forgetting to call sunsu_change_speed().  The reason
> that replugging in the mouse cable "fixes things" is that
> causes a BREAK interrupt which in turn caused a call to
> sunsu_change_speed() which would get the chip setup properly.

[... skipped patch ...]

Now it's working fine, many thanks!

Tomas


