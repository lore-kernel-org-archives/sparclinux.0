From: Konrad Eisele <konrad@gaisler.com>
Date: Wed, 04 Apr 2012 09:35:46 +0000
Subject: Re: [PATCH]sparc32: GENERIC_CLOCKEVENTS support
Message-Id: <4F7C15F2.6010603@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1328652576.12417.3.camel@hp>
In-Reply-To: <1328652576.12417.3.camel@hp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Copy of time_32.c:timer_interrupt
>
> Are there any special reason for this duplication that I have missed?

The names are maybe similar but the parameters to time_ce and time_cs
are different, the frequency cannot be patched for the Leon case
with a lot of modifications in the generic sparc code.
-- Konrad

