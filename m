From: Bill Davidsen <davidsen@tmr.com>
Date: Fri, 19 Oct 2007 02:55:46 +0000
Subject: Re: [BUG] Raid5 trouble
Message-Id: <47181CB2.1060602@tmr.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4714BB92.7040701@systella.fr> <47161CE3.80909@systella.fr>	 <e9c3a7c20710170758p4046ca44labe370e94bca6e93@mail.gmail.com> <e9c3a7c20710170840u2ed8d6a9x26523eec6700ad11@mail.gmail.com>
In-Reply-To: <e9c3a7c20710170840u2ed8d6a9x26523eec6700ad11@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Williams <dan.j.williams@intel.com>
Cc: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>, linux-raid@vger.kernel.org, sparclinux@vger.kernel.org

Dan Williams wrote:
> I found a problem which may lead to the operations count dropping
> below zero.  If ops_complete_biofill() gets preempted in between the
> following calls:
>
> raid5.c:554> clear_bit(STRIPE_OP_BIOFILL, &sh->ops.ack);
> raid5.c:555> clear_bit(STRIPE_OP_BIOFILL, &sh->ops.pending);
>
> ...then get_stripe_work() can recount/re-acknowledge STRIPE_OP_BIOFILL
> causing the assertion.  In fact, the 'pending' bit should always be
> cleared first, but the other cases are protected by
> spin_lock(&sh->lock).  Patch attached.
>   

Once this patch has been vetted, can it be offered to -stable for 
2.6.23? Or to be pedantic, it *can*, will you make that happen?

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

