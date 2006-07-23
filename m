From: David Miller <davem@davemloft.net>
Date: Sun, 23 Jul 2006 08:09:04 +0000
Subject: Re: Compile ESP
Message-Id: <20060723.010904.70217924.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <EC625B79-6F87-41C4-835E-5EF2E80B7684@iacookie.net>
In-Reply-To: <EC625B79-6F87-41C4-835E-5EF2E80B7684@iacookie.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I've forwarded your report to linux-scsi since the scsi
folks removed the ->data_cmnd[] member from the structure
and thus broke the build.
