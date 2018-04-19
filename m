From: Tom Hromatka <tom.hromatka@oracle.com>
Date: Thu, 19 Apr 2018 13:14:30 +0000
Subject: Re: [PATCH 1/2] char: sparc64: Add privileged ADI driver
Message-Id: <02055d2b-eabf-49b0-4e8b-40842b92101f@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180418162958.442909-1-tom.hromatka@oracle.com>
 <20180418162958.442909-2-tom.hromatka@oracle.com>
 <20180419074536.GA20145@kroah.com>
In-Reply-To: <20180419074536.GA20145@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org



On 04/19/2018 01:45 AM, Greg KH wrote:
> On Wed, Apr 18, 2018 at 10:29:57AM -0600, Tom Hromatka wrote:
>> +/*
>> + * Copyright (c) 2017, 2018, Oracle and/or its affiliates. All rights reserved.
>> + * Author: Tom Hromatka <tom.hromatka@oracle.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License version 2
>> + * as published by the Free Softare Foundation; or, when distributed
>> + * separately from the Linux kernel or incorporated into other
>> + * software packages, subject to the following license:
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a copy
>> + * of this source file (the "Software"), to deal in the Software without
>> + * restriction, including without limitation the rights to use, copy, modify,
>> + * merge, publish, distribute, sublicense, and/or sell copies of the Software,
>> + * and to permit persons to whom the Software is furnished to do so, subject to
>> + * the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
>> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
>> + * IN THE SOFTWARE.
>> + */
> Please just use a single SPDX line at the top of the file for this huge
> license boiler-plate.
>
> thanks,
>
> greg k-h

Thanks.   Will do.

Tom


