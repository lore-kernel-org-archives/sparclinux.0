From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Tue, 19 Sep 2017 07:06:37 +0000
Subject: Re: [PATCH] Expose some h/w info from ILOM to userspace via sysfs
Message-Id: <00251eaf-5304-b295-7026-525bb62f4b07@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <baf0b81a-0265-ed20-52c8-e5c558f62c47@oracle.com>
In-Reply-To: <baf0b81a-0265-ed20-52c8-e5c558f62c47@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> If some small library converts the blob into hierachical tree of text
> objects, _WHAT_ is the difference?
>
> We don't export things multiple ways form the kernel.
>
> We have an existing mechanism for mdesc export, please use it.

This email thread is not about mdesc, you must be confused.

AFAIK no data from the ILOM is exposed in any way inside the kernel and 
there is no existing library to parse the output from the ILOM command 
line. This module hence provides new pieces of information that don't 
exist yet in any form from within Linux, so this module is eligible to 
being exported via sysfs using your very own standards (as drawn up in 
the mdesc module thread).

The main purpose of this ILOM module is to provide more hardware 
information to utilities like lshw.

Another use is to provide detailed information to utilities that gather 
a snapshot of the system to send to support teams, for example it's not 
possible at the moment to get the machine firmware versions or RAM DIMM 
details, they're only available through the ILOM UI.

On x86 this kind of info is available mostly through DMI tables which 
lack on Sparc (for good reasons, DMI is a thing of the past) but 
unfortunately for sparclinux there is no mechanism in place to achieve 
the same as DMI.

-eric
