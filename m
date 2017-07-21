From: Allen <allen.pais@oracle.com>
Date: Fri, 21 Jul 2017 10:55:26 +0000
Subject: Re: [PATCH 1/3] sparc64: recognize and support sparc M8 cpu type
Message-Id: <5971DD8A.3090901@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1500536437-14589-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1500536437-14589-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Richard,

>> +/* CPU Constants */
>> +#define NIAGARA1               1
>> +#define NIAGARA2               2
>> +#define NIAGARA3               3
>> +#define NIAGARA4               4
>> +#define NIAGARA5               5
>> +#define M6                     6
>> +#define M7                     7
>> +#define M8                     8
> All of the above were character constants in the original.
>

  Yep. It was just a rough diff for RFC. If the thought is fine, I'll 
clean and send out a patch.

- Allen
