From: Bjorn Helgaas <helgaas@kernel.org>
Date: Tue, 20 Mar 2018 20:14:34 +0000
Subject: Re: [PATCH v1 0/2] PCI: Sparc 64-bit resource fixups
Message-Id: <20180320201434.GB137590@bhelgaas-glaptop.roam.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180319171140.GA52750@bhelgaas-glaptop.roam.corp.google.com>
 <20180319.142831.793002554436316260.davem@davemloft.net>
 <20180319193854.GI77194@bhelgaas-glaptop.roam.corp.google.com>
 <20180319.193341.105600714432834778.davem@davemloft.net>
In-Reply-To: <20180319.193341.105600714432834778.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: david.ahern@oracle.com, alex.williamson@redhat.com, airlied@linux.ie, linux-pci@vger.kernel.org, linux@iam.tj, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, khalid.aziz@oracle.com, sparclinux@vger.kernel.org, yinghai@kernel.org

On Mon, Mar 19, 2018 at 07:33:41PM -0400, David Miller wrote:
> From: Bjorn Helgaas <helgaas@kernel.org>
> Date: Mon, 19 Mar 2018 14:38:54 -0500
> 
> > I'd be happy to remove both.  But I wonder how X init works on
> > sparc.
> 
> It's been many years since I worked on this, but I think it
> mapped and used the PCI ROM resource for this.

Thanks, I posted a v2 series that removes the System ROM and Video ROM
areas completely.
