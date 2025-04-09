provider "aws"{
    region = "af-south-1"
}


resource "aws_connect_hours_of_operation" "Virgin-Active-Hours_of_Operation" {
  instance_id = "70fb22ed-9bcf-47c7-b442-6c2307be4e2c"
  name        = "Virgin Active Office Hours"
  description = "Monday office hours"
  time_zone   = "EST"

  config {
    day = "MONDAY"

    end_time {
      hours   = 23
      minutes = 8
    }

    start_time {
      hours   = 8
      minutes = 0
    }
  }

  config {
    day = "TUESDAY"

    end_time {
      hours   = 21
      minutes = 0
    }

    start_time {
      hours   = 9
      minutes = 0
    }
  }
  config {
    day = "WEDNESDAY"

    end_time {
      hours   = 21
      minutes = 0
    }

    start_time {
      hours   = 9
      minutes = 0
    }
  }
config {
    day = "THURSDAY"

    end_time {
      hours   = 21
      minutes = 0
    }

    start_time {
      hours   = 9
      minutes = 0
    }
  }
config {
    day = "FRIDAY"

    end_time {
      hours   = 21
      minutes = 0
    }

    start_time {
      hours   = 9
      minutes = 0
    }
  }
  config {
    day = "SATURDAY"

    end_time {
      hours   = 21
      minutes = 0
    }

    start_time {
      hours   = 9
      minutes = 0
    }
  }
  config {
    day = "SUNDAY"

    end_time {
      hours   = 21
      minutes = 0
    }

    start_time {
      hours   = 9
      minutes = 0
    }
  }



  tags = {
    "Name" = "Virgin Active Hours of Operation"
  }
}