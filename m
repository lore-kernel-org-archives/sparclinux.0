From: David Miller <davem@davemloft.net>
Date: Fri, 07 Aug 2015 22:22:28 +0000
Subject: Re: [PATCH] Fix incorrect ASI_ST_BLKINIT_MRU_S value
Message-Id: <20150807.152228.1049146473253852401.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1438980455-9214-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1438980455-9214-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Fri,  7 Aug 2015 14:47:35 -0600

> ASI_ST_BLKINIT_MRU_S is incorrectly defined as 0xf2 when it
> should be 0xf3 according to section 10.3.1 of the Sparc
> Architecture manual.
> 
> 
> Signed-off-by: Rob Gardner <rob.gardner@oracle.com>

Applied, but please format your Subject line properly next
time.

After "[PATCH] " should be a subsystem name, then a colon, then
a space, and then your one-line description.

In this case the appropriate subsystem name would be "sparc64: "

Also, please do not place extraneous empty lines in your commit
message, as you did here.

Thank you.
