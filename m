From: Valentin Schneider <valentin.schneider@arm.com>
Date: Tue, 12 Mar 2019 09:43:27 +0000
Subject: Re: [PATCH 12/14] sparc64: rtrap: Remove unneeded need_resched() loop
Message-Id: <1a2c2001-96ae-23c0-c043-e128e24d5560@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190311224752.8337-1-valentin.schneider@arm.com>
 <20190311224752.8337-13-valentin.schneider@arm.com>
 <20190311.161313.458909688496508375.davem@davemloft.net>
In-Reply-To: <20190311.161313.458909688496508375.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Hi,

On 11/03/2019 23:13, David Miller wrote:
[...]
> 
> We must re-evaluate the %tstate value stored in ptregs, you cannot
> make this change.
> 

That's the one I was the less sure about, thanks for clearing it up and
sorry for the noise.
