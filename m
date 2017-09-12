From: Rob Gardner <rob.gardner@oracle.com>
Date: Tue, 12 Sep 2017 04:27:59 +0000
Subject: Re: [PATCH] sparc64: Oracle DAX infrastructure
Message-Id: <df154b48-70cf-1542-07bd-0e89b9a685d0@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1505169129-36547-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1505169129-36547-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 09/11/2017 10:17 PM, David Miller wrote:
> From: Rob Gardner <rob.gardner@oracle.com>
> Date: Mon, 11 Sep 2017 17:28:19 -0600
>
>> The stubs/templates/constants reflect the hypervisor APIs, so there is
>> not very much flexibility in how these are done.
> There is no reason to add hypervisor calls to the kernel until there is
> also a user.
>
> We always have a requirement to sequence a new interface in the kernel
> with and actual user of that interface.
>

OK, point taken. Any guidance on the driver, or shall we just send the 
two patches?

Rob

