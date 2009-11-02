From: David Miller <davem@davemloft.net>
Date: Mon, 02 Nov 2009 12:28:33 +0000
Subject: Re: nocache/highmem mapping
Message-Id: <20091102.042833.53703136.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4ACB63BC.90200@gaisler.com>
In-Reply-To: <4ACB63BC.90200@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>
Date: Mon, 02 Nov 2009 13:33:05 +0100

> David Miller wrote:
>> From: Konrad Eisele <konrad@gaisler.com>
>> Date: Tue, 06 Oct 2009 17:35:24 +0200
>> I looked over this in detail and I can't see what the problem
>> is.
> 
> You are right. Now that you say that PKMAP_BASE should be
> 0xfc800000 instead of 0xfc500000 I went over my local version
> of the code and saw what went wrong on my machine:
> A earalier patch was aligning PKMAP_BASE to an odd value,
> this was done because I was patching my local version of the
> sourcecode to support a hardware-srmmu-configuration with
> pagesize > 4k. Thanks that you pointed it out. Sorry for
> the confusion.

No problem, I'm just glad this is resolved.
