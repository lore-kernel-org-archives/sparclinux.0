From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Wed, 20 Sep 2017 07:04:22 +0000
Subject: Re: [PATCH] Expose some h/w info from ILOM to userspace via sysfs
Message-Id: <ffe433ac-2a2c-fdf5-6c03-c52720a01a53@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <baf0b81a-0265-ed20-52c8-e5c558f62c47@oracle.com>
In-Reply-To: <baf0b81a-0265-ed20-52c8-e5c558f62c47@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org


> Please give examples.

There are redundancies with what Linux has figured of the system, for 
example:

     /System/Memeory = 512 GB

     /System/CPU_Modules/installed_cpu_modules = 2 (lscpu shows this by 
using info in sysfs)

     /System/CPU_Modules/total_cores = 32 (lscpu shows this by using 
info in sysfs)

     /System/Storage/installed_disks = 4

     ...


as well as redundancies within the ilom's show output, for example:

     /System/host_primary_mac_address = /HOST/macaddress

     /System/ilom_mac_address = /SP/network/macaddress = 
/SP/network/outofbandmacaddress

     ...

-eric
