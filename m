From: Marc Zyngier <maz@misterjones.org>
Date: Tue, 18 Jul 2006 06:25:17 +0000
Subject: Re: 2.6.18-rc1 fails to boot on E250
Message-Id: <wrpslkzbfaq.fsf@wild-wind.fr.eu.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20060714.165308.83620688.davem@davemloft.net>
In-Reply-To: <20060714.165308.83620688.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>>>>> "David" = David Miller <davem@davemloft.net> writes:

David> Ok, your patch was only half-correct. :-) This patch below,
David> which goes on top of your's, fixes things up and also fixes a
David> problem with the uart table sizing in this driver.

Dave, you rock. :-)

The box booted all the way to userland, without any problem.

Thanks a lot for your help !

	M.
-- 
And if you don't know where you're going, any road will take you there...
