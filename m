From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Mon, 05 Apr 2004 18:11:47 +0000
Subject: Re: Oops when booting 2.6.5
Message-Id: <20040405181147.GA22673@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040405153414.GC1430@artsapartment.org>
In-Reply-To: <20040405153414.GC1430@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Apr 05, 2004 at 10:34:14AM -0500, Art Haas wrote:

> I compiled the kernel with Debian's GCC-3.3 package. When booting the
> 2.6.5-rc kernels there was no oops. The oops occur when the initscripts
> are trying to active swap with 'swapon -a'.

Known issue, being worked on.  Thanks for the report.

-- 
Keith M Wesolowski
