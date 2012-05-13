From: David Miller <davem@davemloft.net>
Date: Sun, 13 May 2012 01:23:56 +0000
Subject: Re: [PATCH] sparc32: Pass -mcpu=v7 explicitly to gcc.
Message-Id: <20120512.212356.2121207651878467023.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120512.182057.119046891010844835.davem@davemloft.net>
In-Reply-To: <20120512.182057.119046891010844835.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Tom Callaway <tcallawa@redhat.com>
Date: Sat, 12 May 2012 20:27:45 -0400

> On 05/12/2012 06:20 PM, David Miller wrote:
>> 
>> We should be agnostic to what gcc happens to be generating by default.
> 
> If you're dropping sun4c, why not -mcpu=v8?

We cannot generate hardware multiply and divisde instructions until
we remove Cypress support.

Cypress is a sun4m chip but like sun4c it lacks HW integer multiply
and divide.
