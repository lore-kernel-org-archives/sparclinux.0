From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 25 Mar 2019 15:24:09 +0000
Subject: Re: [PATCH 0/2] Remove support for deprecated %pf and %pF in vsprintf
Message-Id: <20190325152409.GF9224@smile.fi.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190322132108.25501-1-sakari.ailus@linux.intel.com>
 <CAMuHMdVmqqjVx7As9AAywYxYXG=grijF5rF77OBn6TUjM9+xKw@mail.gmail.com>
 <20190322135350.2btpno7vspvewxvk@paasikivi.fi.intel.com>
 <20190322170550.GX9224@smile.fi.intel.com>
 <20190324211008.lypghym3gqcp62th@mara.localdomain>
 <20190324211932.GK9224@smile.fi.intel.com>
 <20190325151259.2w22y4ijqilrbaxj@kekkonen.localdomain>
In-Reply-To: <20190325151259.2w22y4ijqilrbaxj@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Petr Mladek <pmladek@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, linux-um@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, netdev <netdev@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, xen-devel@lists.xenproject.org, ceph-devel <ceph-devel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@l>

On Mon, Mar 25, 2019 at 05:13:00PM +0200, Sakari Ailus wrote:

> All other invalid pointer conversion specifiers currently result into a
> warning only. I see that as an orthogonal change to this set. I found
> another issue in checkpatch.pl that may require some discussion; would you
> be ok with addressing this in another set?

If it looks better that way, I have no objection.

-- 
With Best Regards,
Andy Shevchenko
