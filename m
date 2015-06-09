From: David Miller <davem@davemloft.net>
Date: Tue, 09 Jun 2015 07:34:14 +0000
Subject: Re: Linux Sparc FPU register corruption
Message-Id: <20150609.003414.731851656168946673.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
In-Reply-To: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Your test is faulty.

You cannot use ASI_BLK_P loads or stores without appropriate memory
barriers around them.

The rules for when and where you need the memory barriers are
complicated, especially if you want to incur the cost of the memory
barrier as infrequently as possible.
