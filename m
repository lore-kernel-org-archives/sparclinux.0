From: Andreas Schwab <schwab@linux-m68k.org>
Date: Sat, 07 May 2016 10:46:11 +0000
Subject: Re: [patch V4] lib: GCD: Use binary GCD algorithm instead of Euclidean
Message-Id: <87d1oyrvrg.fsf@linux-m68k.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20160507084129.7284.qmail@ns.horizon.com>
In-Reply-To: <20160507084129.7284.qmail@ns.horizon.com> (George Spelvin's
 message of "7 May 2016 04:41:29 -0400")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

"George Spelvin" <linux@horizon.com> writes:

> Your benchmark code doesn't have to have a separate code path if
> __x86_64__; rdtsc works on 32-bit code just as well.

Take a look at the CC: list.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
