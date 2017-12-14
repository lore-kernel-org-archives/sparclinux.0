From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Thu, 14 Dec 2017 14:59:55 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <06773f18-552d-9d0a-9217-05fa79da637a@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

As I stated early in the email thread, mdesc sysfs module has the same

permissions as /dev/mdesc chardev. So if you're happy with /dev/mdesc

being root, then you're also happy with mdesc sysfs expsing the same data

with the same perimssions and I don't understand that fuss around the audit.

Please elaborate as I don't understand what's happening here. Thank you.

Eric Saint-Etienne - Principal Linux Kernel Engineer

On 14/12/17 13:44, David Miller wrote:
> From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
> Date: Thu, 14 Dec 2017 11:01:58 +0000
>
>> That said this sanitization task should be on top of your sparc todo
>> list IMHO because the existing /dev/mdesc driver doesn't filter
>> anything as of today, so it leaks critical/sensitive data to the OS.
> It's root only.

