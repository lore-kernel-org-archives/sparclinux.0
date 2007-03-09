From: William Lee Irwin III <wli@holomorphy.com>
Date: Fri, 09 Mar 2007 11:20:18 +0000
Subject: Re: [PATCH] Fix sparc TIF_USEDFPU flag atomicity
Message-Id: <20070309112018.GB2994@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20070309031227.GC9462@Krystal> <20070308.212523.45514581.davem@davemloft.net>
In-Reply-To: <20070308.212523.45514581.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mathieu.desnoyers@polymtl.ca, akpm@linux-foundation.org, mbligh@google.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Thu, 8 Mar 2007 22:12:27 -0500 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:
>> Fix sparc TIF_USEDFPU flag atomicity
>> Non atomic update of TIF can be very dangerous, except at thread structure
>> creation time. Here I standardize the TIF_USEDFPU usage of the sparc arch.
>> Applies on 2.6.20.
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

On Thu, Mar 08, 2007 at 09:25:23PM -0800, David Miller wrote:
> Also applied, thanks a lot.

Thanks again for doing just about everything here while I get my act
back together (never mind how preposterously long it's taking).

Acked-by: William Irwin <wli@holomorphy.com>


-- wli
